import InventoryGrid from './InventoryGrid';
import { useAppSelector } from '../../store';
import { selectLeftInventory } from '../../store/inventory';
import { useMemo } from 'react';
import { getTotalWeight } from '../../helpers';

const LeftInventory: React.FC = () => {
  const leftInventory = useAppSelector(selectLeftInventory);

  const weight = useMemo(
    () =>
      leftInventory.maxWeight !== undefined
        ? Math.floor(getTotalWeight(leftInventory.items) * 1000) / 1000
        : 0,
    [leftInventory.maxWeight, leftInventory.items]
  );

  return (
    <div className="left-inventory">
      <div className="pockets-header">
        <span className="pockets-title">Pockets</span>
        {leftInventory.maxWeight && (
          <span className="pockets-weight">
            {(weight / 1000).toLocaleString('en-us', {
              minimumFractionDigits: 2,
              maximumFractionDigits: 2,
            })}
            /{(leftInventory.maxWeight / 1000).toLocaleString('en-us', {
              minimumFractionDigits: 0,
            })}
            kg
          </span>
        )}
      </div>
      <InventoryGrid inventory={leftInventory} />
    </div>
  );
};

export default LeftInventory;
