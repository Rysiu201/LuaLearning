import { useState } from 'react';
import InventoryGrid from './InventoryGrid';
import { useAppSelector } from '../../store';
import { selectBackpackInventory } from '../../store/inventory';

const BackpackInventory: React.FC = () => {
  const backpack = useAppSelector(selectBackpackInventory);
  const [collapsed, setCollapsed] = useState(false);
  if (!backpack.id) return null;

  return (
    <div className="backpack-inventory">
      <h2 className="pockets-title">Backpack ({backpack.label})</h2>
      <InventoryGrid
        inventory={backpack}
        showSlotNumbers={false}
        collapsible
        collapsed={collapsed}
        onToggleCollapse={() => setCollapsed(!collapsed)}
      />
    </div>
  );
};

export default BackpackInventory;
