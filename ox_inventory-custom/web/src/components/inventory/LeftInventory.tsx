import InventoryGrid from './InventoryGrid';
import { useAppSelector } from '../../store';
import { selectLeftInventory } from '../../store/inventory';

const LeftInventory: React.FC = () => {
  const leftInventory = useAppSelector(selectLeftInventory);

  return (
    <div className="right-inventory">
      <InventoryGrid inventory={leftInventory} />
    </div>
  );
};

export default LeftInventory;
