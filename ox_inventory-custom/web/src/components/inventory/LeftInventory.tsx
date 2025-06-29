import InventoryGrid from './InventoryGrid';
import { useAppSelector } from '../../store';
import { selectPocketsInventory } from '../../store/inventory';

const LeftInventory: React.FC = () => {
  const leftInventory = useAppSelector(selectPocketsInventory);

  return (
    <div className="left-inventory">
      <h2 className="pockets-title">Pockets</h2>
      <InventoryGrid inventory={leftInventory} showSlotNumbers={false} />
    </div>
  );
};

export default LeftInventory;
