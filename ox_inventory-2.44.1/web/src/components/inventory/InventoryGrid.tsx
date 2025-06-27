import React, { useEffect, useMemo, useRef, useState } from 'react';
import { Inventory } from '../../typings';
import WeightBar from '../utils/WeightBar';
import InventorySlot from './InventorySlot';
import { getTotalWeight } from '../../helpers';
import { useAppSelector } from '../../store';
import { useIntersection } from '../../hooks/useIntersection';

const PAGE_SIZE = 30;

const InventoryGrid: React.FC<{ inventory: Inventory }> = ({ inventory }) => {
  const maxWeight = inventory.type === 'player' ? 100000 : inventory.maxWeight;
  const label = inventory.type === 'player' ? 'Pockets' : inventory.label;
  const weight = useMemo(
    () => Math.floor(getTotalWeight(inventory.items) * 1000) / 1000,
    [inventory.items]
  );
  const [page, setPage] = useState(0);
  const containerRef = useRef(null);
  const { ref, entry } = useIntersection({ threshold: 0.5 });
  const isBusy = useAppSelector((state) => state.inventory.isBusy);

  useEffect(() => {
    if (entry && entry.isIntersecting) {
      setPage((prev) => ++prev);
    }
  }, [entry]);
  return (
    <>
      <div
        className={`inventory-grid-wrapper ${
          inventory.type === 'player' ? 'pockets-section' : ''
        }`}
        style={{ pointerEvents: isBusy ? 'none' : 'auto' }}
      >
        <div>
          <div className="inventory-grid-header-wrapper">
            <p>{label}</p>
            {maxWeight && (
              <p>
                {weight / 1000}/{maxWeight / 1000}kg
              </p>
            )}
          </div>
          <WeightBar percent={maxWeight ? (weight / maxWeight) * 100 : 0} />
        </div>
        <div
          className={`inventory-grid-container ${
            inventory.type === 'player' ? 'pockets-grid' : ''
          }`}
          ref={containerRef}
        >
          <>
            {inventory.items.slice(0, (page + 1) * PAGE_SIZE).map((item, index) => (
              <InventorySlot
                key={`${inventory.type}-${inventory.id}-${item.slot}`}
                item={item}
                ref={index === (page + 1) * PAGE_SIZE - 1 ? ref : null}
                inventoryType={inventory.type}
                inventoryGroups={inventory.groups}
                inventoryId={inventory.id}
              />
            ))}
          </>
        </div>
      </div>
    </>
  );
};

export default InventoryGrid;
