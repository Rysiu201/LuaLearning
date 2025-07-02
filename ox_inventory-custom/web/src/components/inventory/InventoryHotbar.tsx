import React, { useState } from 'react';
import { getItemUrl, isSlotWithItem } from '../../helpers';
import useNuiEvent from '../../hooks/useNuiEvent';
import { Items } from '../../store/items';
import WeightBar from '../utils/WeightBar';
import { useAppSelector } from '../../store';
import { selectEquipmentInventory } from '../../store/inventory';
import { SlotWithItem } from '../../typings';
import SlideUp from '../utils/transitions/SlideUp';

const InventoryHotbar: React.FC = () => {
  const [hotbarVisible, setHotbarVisible] = useState(false);
  const items = useAppSelector(selectEquipmentInventory).items.slice(0, 5);

  //stupid fix for timeout
  const [handle, setHandle] = useState<NodeJS.Timeout>();
  useNuiEvent('toggleHotbar', () => {
    if (hotbarVisible) {
      setHotbarVisible(false);
    } else {
      if (handle) clearTimeout(handle);
      setHotbarVisible(true);
      setHandle(setTimeout(() => setHotbarVisible(false), 3000));
    }
  });

  return (
    <SlideUp in={hotbarVisible}>
      <div className="hotbar-container">
        {items.map((item) => {
          let quality: string | undefined = isSlotWithItem(item)
            ? item.metadata?.quality
            : undefined;
          if (!quality) quality = 'Common';
          return (
            <div className="hotbar-item-slot" key={`hotbar-${item.slot}`}> 
              {isSlotWithItem(item) && (
                <div className="item-slot-wrapper">
                  <div className="item-hotslot-header-wrapper">
                    <div className="inventory-slot-number">{item.slot}</div>
                    <span className={`item-quality quality-${quality.toLowerCase()}`}>{quality}</span>
                    <span className="item-count">
                      {item.count ? item.count.toLocaleString('en-us') + `x` : ''}
                    </span>
                  </div>
                  <div
                    className="item-image"
                    style={{ backgroundImage: `url(${getItemUrl(item as SlotWithItem)})` }}
                  />
                  <div>
                    {item.durability !== undefined && (
                      <WeightBar percent={item.durability} durability />
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
        })}
      </div>
    </SlideUp>
  );
};

export default InventoryHotbar;
