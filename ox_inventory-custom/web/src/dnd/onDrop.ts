import { canStack, findAvailableSlot, getTargetInventory, isSlotWithItem } from '../helpers';
import { validateMove } from '../thunks/validateItems';
import { store } from '../store';
import { DragSource, DropTarget, InventoryType, SlotWithItem } from '../typings';
import { moveSlots, stackSlots, swapSlots } from '../store/inventory';
import { Items } from '../store/items';

const isWeapon = (name: string) => name.toUpperCase().startsWith('WEAPON_');

const allowedInSlot = (slot: number, name: string) => {
  if (slot === 1 || slot === 2) return isWeapon(name);
  if (slot >= 3 && slot <= 5) return !isWeapon(name);
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

export const onDrop = (source: DragSource, target?: DropTarget) => {
  const { inventory: state } = store.getState();

  const { sourceInventory, targetInventory } = getTargetInventory(state, source.inventory, target?.inventory);

  const sourceSlot = sourceInventory.items[source.item.slot - 1] as SlotWithItem;

  const sourceData = Items[sourceSlot.name];

  if (sourceData === undefined) return console.error(`${sourceSlot.name} item data undefined!`);

  // If dragging from container slot
  if (sourceSlot.metadata?.container !== undefined) {
    // Prevent storing container in container
    if (
      targetInventory.type === InventoryType.CONTAINER ||
      targetInventory.type === InventoryType.BACKPACK
    )
      return console.log(`Cannot store container ${sourceSlot.name} inside another container`);

    // Prevent dragging of container slot when opened
    if (
      state.rightInventory.id === sourceSlot.metadata.container ||
      state.backpackInventory.id === sourceSlot.metadata.container
    )
      return console.log(`Cannot move container ${sourceSlot.name} when opened`);
  }

  const targetSlot = target
    ? targetInventory.items[target.item.slot - 1]
    : findAvailableSlot(sourceSlot, sourceData, targetInventory.items);

  if (targetSlot === undefined) return console.error('Target slot undefined!');

  if (
    targetInventory.type === InventoryType.PLAYER &&
    !allowedInSlot(targetSlot.slot, sourceSlot.name)
  ) {
    return console.log(`Item ${sourceSlot.name} cannot go in slot ${targetSlot.slot}`);
  }

  // If dropping on container slot when opened
  if (
    targetSlot.metadata?.container !== undefined &&
    state.rightInventory.id === targetSlot.metadata.container
  )
    return console.log(`Cannot swap item ${sourceSlot.name} with container ${targetSlot.name} when opened`);

  const count =
    state.shiftPressed && sourceSlot.count > 1 && sourceInventory.type !== 'shop'
      ? Math.floor(sourceSlot.count / 2)
      : state.itemAmount === 0 || state.itemAmount > sourceSlot.count
      ? sourceSlot.count
      : state.itemAmount;

  const data = {
    fromSlot: sourceSlot,
    toSlot: targetSlot,
    fromType: sourceInventory.type,
    toType: targetInventory.type,
    count: count,
  };

  store.dispatch(
    validateMove({
      ...data,
      fromSlot: sourceSlot.slot,
      toSlot: targetSlot.slot,
    })
  );

  isSlotWithItem(targetSlot, true)
    ? sourceData.stack && canStack(sourceSlot, targetSlot)
      ? store.dispatch(
          stackSlots({
            ...data,
            toSlot: targetSlot,
          })
        )
      : store.dispatch(
          swapSlots({
            ...data,
            toSlot: targetSlot,
          })
        )
    : store.dispatch(moveSlots(data));
};
