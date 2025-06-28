import InventoryGrid from './InventoryGrid';
import { useAppSelector } from '../../store';
import { selectLeftInventory } from '../../store/inventory';

const LeftInventory: React.FC = () => {
  const leftInventory = useAppSelector(selectLeftInventory);

  return (
    <div className="left-inventory">
      <h2 className="pockets-title">Pockets</h2>
      <InventoryGrid inventory={leftInventory} />
    </div>
  );
};

export default LeftInventory;
