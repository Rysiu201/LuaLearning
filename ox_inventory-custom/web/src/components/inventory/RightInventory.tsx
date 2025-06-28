import InventoryGrid from './InventoryGrid';
import { useAppSelector } from '../../store';
import { selectRightInventory } from '../../store/inventory';

const RightInventory: React.FC = () => {
  const rightInventory = useAppSelector(selectRightInventory);

  return (
    <div className="left-inventory">
      <InventoryGrid inventory={rightInventory} />
    </div>
  );
};

export default RightInventory;
