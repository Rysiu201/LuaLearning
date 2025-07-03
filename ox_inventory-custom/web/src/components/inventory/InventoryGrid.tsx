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
  collapsible?: boolean;
  collapsed?: boolean;
  onToggleCollapse?: () => void;
  showWeightBar?: boolean;
}

const InventoryGrid: React.FC<InventoryGridProps> = ({
  inventory,
  showSlotNumbers = true,
  collapsible = false,
  collapsed = false,
  onToggleCollapse,
  showWeightBar = true,
}) => {
  const isGround = inventory.type === 'drop' || inventory.type === 'newdrop';
  const weight = useMemo(
    () => Math.floor(getTotalWeight(inventory.items) * 1000) / 1000,
    [inventory.items]
  );
  const isBusy = useAppSelector((state) => state.inventory.isBusy);
  return (
    <>
      <div className="inventory-grid-wrapper" style={{ pointerEvents: isBusy ? 'none' : 'auto' }}>
        <div>
          <div className={`inventory-grid-header-wrapper ${isGround ? 'ground-header' : ''}`}>
            {!isGround && <p>{inventory.label}</p>}
            {showWeightBar && (
              <p className="weight-info">
                <span className="weight-icon">⚖</span>
                {weight / 1000}
                {!isGround && inventory.maxWeight ? `/${inventory.maxWeight / 1000}kg` : 'kg'}
                {collapsible && (
                  <button
                    type="button"
                    className="collapse-toggle"
                    onClick={onToggleCollapse}
                  >
                    {collapsed ? '▲' : '▼'}
                  </button>
                )}
              </p>
            )}
          </div>
          {!isGround && showWeightBar && (
            <WeightBar percent={inventory.maxWeight ? (weight / inventory.maxWeight) * 100 : 0} />
          )}
        </div>
        <div className={`inventory-grid-container ${collapsed ? 'collapsed' : ''}`}>
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
