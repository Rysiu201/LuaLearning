import React, { useCallback, useRef } from 'react';
import { DragSource, Inventory, InventoryType, Slot, SlotWithItem } from '../../typings';
import { useDrag, useDragDropManager, useDrop } from 'react-dnd';
import { useAppDispatch, useAppSelector } from '../../store';
import WeightBar from '../utils/WeightBar';
import { onDrop } from '../../dnd/onDrop';
import { onDrop as onGroundDrop } from '../../dnd/onGround';
import { onBuy } from '../../dnd/onBuy';
import { Items } from '../../store/items';
import { canCraftItem, canPurchaseItem, getItemUrl, isSlotWithItem, findAvailableSlot } from '../../helpers';
import { onUse } from '../../dnd/onUse';
import { Locale } from '../../store/locale';
import { onCraft } from '../../dnd/onCraft';
import { validateMove } from '../../thunks/validateItems';
import { selectLeftInventory } from '../../store/inventory';
import { addItem } from '../../store/cart';
import useNuiEvent from '../../hooks/useNuiEvent';
import { ItemsPayload } from '../../reducers/refreshSlots';
import { closeTooltip, openTooltip } from '../../store/tooltip';
import { openContextMenu } from '../../store/contextMenu';
import { useMergeRefs } from '@floating-ui/react';

interface SlotProps {
  inventoryId: Inventory['id'];
  inventoryType: Inventory['type'];
  inventoryGroups: Inventory['groups'];
  item: Slot;
  showHotkeyNumber?: boolean;
}

const InventorySlot: React.ForwardRefRenderFunction<HTMLDivElement, SlotProps> = (
  { item, inventoryId, inventoryType, inventoryGroups, showHotkeyNumber },
  ref
) => {
  const manager = useDragDropManager();
  const dispatch = useAppDispatch();
  const leftInventory = useAppSelector(selectLeftInventory);
  const timerRef = useRef<number | null>(null);

  const allowedInSlot = (slot: number, name: string) => {
    const isWeapon = name.toUpperCase().startsWith('WEAPON_');
    if (slot === 1 || slot === 2) return isWeapon;
    if (slot >= 3 && slot <= 5) return !isWeapon;
    if (slot === 6)
      return (
        name === 'paperbag' ||
        name === 'backpack1' ||
        name === 'backpack2' ||
        name === 'backpack3' ||
        name === 'backpack4' ||
        name === 'backpack5'
      );
    if (slot === 7) return name === 'armour';
    if (slot === 8) return name.toLowerCase().includes('phone');
    if (slot === 9) return name === 'parachute';
    return true;
  };

  const canDrag = useCallback(() => {
    return (
      isSlotWithItem(item) &&
      canPurchaseItem(item, { type: inventoryType, groups: inventoryGroups }) &&
      canCraftItem(item, inventoryType)
    );
  }, [item, inventoryType, inventoryGroups]);

  const [{ isDragging }, drag] = useDrag<DragSource, void, { isDragging: boolean }>(
    () => ({
      type: 'SLOT',
      collect: (monitor) => ({
        isDragging: monitor.isDragging(),
      }),
      item: () =>
        isSlotWithItem(item, inventoryType !== InventoryType.SHOP)
          ? {
              inventory: inventoryType,
              item: {
                name: item.name,
                slot: item.slot,
              },
              image: item?.name && `url(${getItemUrl(item) || 'none'}`,
              itemData: inventoryType === InventoryType.SHOP ? item : undefined,
            }
          : null,
      canDrag,
    }),
    [inventoryType, item]
  );

  const [{ isOver }, drop] = useDrop<DragSource, void, { isOver: boolean }>(
    () => ({
      accept: 'SLOT',
      collect: (monitor) => ({
        isOver: monitor.isOver(),
      }),
      drop: (source) => {
        dispatch(closeTooltip());
        switch (source.inventory) {
          case InventoryType.SHOP:
            onBuy(source, { inventory: inventoryType, item: { slot: item.slot } });
            break;
          case InventoryType.CRAFTING:
            onCraft(source, { inventory: inventoryType, item: { slot: item.slot } });
            break;
          default:
            if (inventoryType === 'newdrop' || inventoryType === 'drop') {
              onGroundDrop(source, { inventory: inventoryType, item: { slot: item.slot } });
            } else {
              onDrop(source, { inventory: inventoryType, item: { slot: item.slot } });
            }
            break;
        }
      },
      canDrop: (source) =>
        (source.item.slot !== item.slot || source.inventory !== inventoryType) &&
        inventoryType !== InventoryType.SHOP &&
        inventoryType !== InventoryType.CRAFTING,
    }),
    [inventoryType, item]
  );

  useNuiEvent('refreshSlots', (data: { items?: ItemsPayload | ItemsPayload[] }) => {
    if (!isDragging && !data.items) return;
    if (!Array.isArray(data.items)) return;

    const itemSlot = data.items.find(
      (dataItem) => dataItem.item.slot === item.slot && dataItem.inventory === inventoryId
    );

    if (!itemSlot) return;

    manager.dispatch({ type: 'dnd-core/END_DRAG' });
  });

  const connectRef = (element: HTMLDivElement) => drag(drop(element));

  const handleContext = (event: React.MouseEvent<HTMLDivElement>) => {
    event.preventDefault();
    if (inventoryType !== 'player' || !isSlotWithItem(item)) return;

    dispatch(openContextMenu({ item, coords: { x: event.clientX, y: event.clientY } }));
  };

  const handleClick = (event: React.MouseEvent<HTMLDivElement>) => {
    dispatch(closeTooltip());
    if (event.detail === 2 && inventoryType === 'shop' && isSlotWithItem(item)) {
      dispatch(addItem({ slot: item.slot, item: item as SlotWithItem, quantity: 1 }));
      return;
    }
    if (timerRef.current) clearTimeout(timerRef.current);
    if (event.ctrlKey && isSlotWithItem(item) && inventoryType !== 'shop' && inventoryType !== 'crafting') {
      if (inventoryType === 'newdrop' || inventoryType === 'drop') {
        onGroundDrop({ item: item, inventory: inventoryType });
      } else {
        onDrop({ item: item, inventory: inventoryType });
      }
    } else if (event.altKey && isSlotWithItem(item) && inventoryType === 'player') {
      onUse(item);
    } else if (event.shiftKey && isSlotWithItem(item) && inventoryType === 'player') {
      if (item.slot <= 9) {
        const target = findAvailableSlot(item as SlotWithItem, Items[item.name]!, leftInventory.items.slice(9));
        if (!target) return;
        dispatch(
          validateMove({
            fromSlot: item.slot,
            fromType: 'player',
            toSlot: target.slot + 9,
            toType: 'player',
            count: item.count,
          })
        );
      } else {
        for (let i = 1; i <= 9; i++) {
          if (allowedInSlot(i, item.name)) {
            const dest = leftInventory.items[i - 1];
            if (!isSlotWithItem(dest)) {
              dispatch(
                validateMove({
                  fromSlot: item.slot,
                  fromType: 'player',
                  toSlot: i,
                  toType: 'player',
                  count: item.count,
                })
              );
              break;
            }
          }
        }
      }
    }
  };

  const refs = useMergeRefs([connectRef, ref]);
  let quality: string | undefined = isSlotWithItem(item) ? item.metadata?.quality : undefined;

  if (!quality) {
    console.warn(`Brak quality dla itemu ${item.name}, ustawiam domyślnie "Common"`, item);
    quality = 'Common';
  }

  return (
    <div
      ref={refs}
      onContextMenu={handleContext}
      onClick={handleClick}
      className={`inventory-slot ${quality ? `rarity-${quality.toLowerCase()}` : ''}`}
      style={{
        filter:
          !canPurchaseItem(item, { type: inventoryType, groups: inventoryGroups }) || !canCraftItem(item, inventoryType)
            ? 'brightness(80%) grayscale(100%)'
            : undefined,
        opacity: isDragging ? 0.4 : 1.0,
        border: isOver ? '1px dashed rgba(255,255,255,0.4)' : '',
      }}
    >
      {isSlotWithItem(item) && (
        <div
          className="item-slot-wrapper"
          onMouseEnter={() => {
            timerRef.current = window.setTimeout(() => {
              dispatch(openTooltip({ item, inventoryType }));
            }, 500) as unknown as number;
          }}
          onMouseLeave={() => {
            dispatch(closeTooltip());
            if (timerRef.current) {
              clearTimeout(timerRef.current);
              timerRef.current = null;
            }
          }}
        >
          <div className={showHotkeyNumber ? 'item-hotslot-header-wrapper' : 'item-slot-header-wrapper'}>
            {showHotkeyNumber && <div className="inventory-slot-number">{item.slot}</div>}
            <span className={`item-quality quality-${quality?.toLowerCase()}`}>{quality}</span>
            <span className="item-count">{item.count ? item.count.toLocaleString('en-us') + `x` : ''}</span>
          </div>
          <div
            className="item-image"
            style={{
              backgroundImage: `url(${item?.name ? getItemUrl(item as SlotWithItem) : 'none'})`,
            }}
          />
          <div>
            {inventoryType !== 'shop' && item?.durability !== undefined && (
              <WeightBar percent={item.durability} durability />
            )}
            {inventoryType === 'shop' && item?.price !== undefined && (
              <>
                {item?.currency !== 'money' && item.currency !== 'black_money' && item.price > 0 && item.currency ? (
                  <div className="item-slot-currency-wrapper">
                    <img
                      src={item.currency ? getItemUrl(item.currency) : 'none'}
                      alt="item-image"
                      style={{
                        imageRendering: '-webkit-optimize-contrast',
                        height: 'auto',
                        width: '2vh',
                        backfaceVisibility: 'hidden',
                        transform: 'translateZ(0)',
                      }}
                    />
                    <p>{item.price.toLocaleString('en-us')}</p>
                  </div>
                ) : (
                  <>
                    {item.price > 0 && (
                      <div
                        className="item-slot-price-wrapper"
                        style={{ color: item.currency === 'money' || !item.currency ? '#2ECC71' : '#E74C3C' }}
                      >
                        <p>
                          {Locale.$ || '$'}
                          {item.price.toLocaleString('en-us')}
                        </p>
                      </div>
                    )}
                  </>
                )}
              </>
            )}
            <div className="inventory-slot-label-box">
              <div className="inventory-slot-label-text">
                {item.metadata?.label ? item.metadata.label : Items[item.name]?.label || item.name}
              </div>
              <div className="inventory-slot-weight">
                {item.weight > 0
                  ? item.weight >= 1000
                    ? `${(item.weight / 1000).toLocaleString('en-us', { minimumFractionDigits: 2 })}kg`
                    : `${item.weight.toLocaleString('en-us', { minimumFractionDigits: 0 })}g`
                  : ''}
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default React.memo(React.forwardRef(InventorySlot));
