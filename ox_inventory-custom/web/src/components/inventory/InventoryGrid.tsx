import React, { useMemo } from 'react';
import { Inventory } from '../../typings';
import WeightBar from '../utils/WeightBar';
import InventorySlot from './InventorySlot';
import { getTotalWeight } from '../../helpers';
import { useAppSelector } from '../../store';

const PAGE_SIZE = 24;

interface InventoryGridProps {
  inventory: Inventory;
  showSlotNumbers?: boolean;
}

const InventoryGrid: React.FC<InventoryGridProps> = ({ inventory, showSlotNumbers = true }) => {
  const weight = useMemo(
    () => (inventory.maxWeight !== undefined ? Math.floor(getTotalWeight(inventory.items) * 1000) / 1000 : 0),
    [inventory.maxWeight, inventory.items]
  );
  const isBusy = useAppSelector((state) => state.inventory.isBusy);
  return (
    <>
      <div className="inventory-grid-wrapper" style={{ pointerEvents: isBusy ? 'none' : 'auto' }}>
        <div>
          <div className="inventory-grid-header-wrapper">
            <p>{inventory.label}</p>
            {inventory.maxWeight && (
              <p>
                <span className="weight-icon">⚖</span>
                {weight / 1000}/{inventory.maxWeight / 1000}kg
              </p>
            )}
          </div>
          <WeightBar percent={inventory.maxWeight ? (weight / inventory.maxWeight) * 100 : 0} />
        </div>
        <div className="inventory-grid-container">
          {inventory.items.slice(0, PAGE_SIZE).map((item) => (
            <InventorySlot
              key={`${inventory.type}-${inventory.id}-${item.slot}`}
              item={item}
              inventoryType={inventory.type}
              inventoryGroups={inventory.groups}
              inventoryId={inventory.id}
              showHotkeyNumber={showSlotNumbers && item.slot <= 5}
            />
          ))}
        </div>
      </div>
    </>
  );
};

export default InventoryGrid;
