import InventoryGrid from './InventoryGrid';
import { useAppSelector } from '../../store';
import { selectLeftInventory } from '../../store/inventory';
import { useMemo } from 'react';
import { getTotalWeight } from '../../helpers';

const LeftInventory: React.FC = () => {
  const leftInventory = useAppSelector(selectLeftInventory);

  const weight = useMemo(
    () => (leftInventory.maxWeight !== undefined ? Math.floor(getTotalWeight(leftInventory.items) * 1000) / 1000 : 0),
    [leftInventory.maxWeight, leftInventory.items]
  );

  const fillPercentage = useMemo(
    () => (leftInventory.maxWeight ? (weight / leftInventory.maxWeight) * 100 : 0),
    [weight, leftInventory.maxWeight]
  );

  return (
    <div className="left-inventory">
      <div className="pockets-header">
        <span className="pockets-title">Pockets</span>
      </div>
      {leftInventory.maxWeight && (
        <div className="weight-container">
          <span className="weight-text">
            {(weight / 1000).toLocaleString('en-us', {
              minimumFractionDigits: 2,
              maximumFractionDigits: 2,
            })}
            /
            {(leftInventory.maxWeight / 1000).toLocaleString('en-us', {
              minimumFractionDigits: 0,
            })}
            kg
          </span>
          <div className="weight-bar">
            <div className="weight-fill" style={{ width: `${fillPercentage}%` }}></div>
          </div>
        </div>
      )}
      <InventoryGrid inventory={leftInventory} hideHeader />
    </div>
  );
};

export default LeftInventory;
