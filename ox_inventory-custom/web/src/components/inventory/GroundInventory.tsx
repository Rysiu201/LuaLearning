import React, { useState } from 'react';
import InventoryGrid from './InventoryGrid';
import { useAppSelector } from '../../store';
import { selectRightInventory } from '../../store/inventory';

const GroundInventory: React.FC = () => {
  const rightInventory = useAppSelector(selectRightInventory);
  const [collapsed, setCollapsed] = useState(false);

  return (
    <div className="ground-inventory">
      <h2 className="pockets-title">Ground</h2>
      <InventoryGrid
        inventory={rightInventory}
        showSlotNumbers={false}
        collapsible
        collapsed={collapsed}
        onToggleCollapse={() => setCollapsed(!collapsed)}
      />
    </div>
  );
};

export default GroundInventory;
