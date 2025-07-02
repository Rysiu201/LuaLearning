import { useState } from 'react';
import InventoryGrid from './InventoryGrid';
import { useAppSelector } from '../../store';
import { selectPocketsInventory } from '../../store/inventory';

const LeftInventory: React.FC = () => {
  const leftInventory = useAppSelector(selectPocketsInventory);
  const [collapsed, setCollapsed] = useState(false);

  return (
    <div className="left-inventory">
      <h2 className="pockets-title">Pockets</h2>
      <InventoryGrid
        inventory={leftInventory}
        showSlotNumbers={false}
        collapsible
        collapsed={collapsed}
        onToggleCollapse={() => setCollapsed(!collapsed)}
      />
    </div>
  );
};

export default LeftInventory;
