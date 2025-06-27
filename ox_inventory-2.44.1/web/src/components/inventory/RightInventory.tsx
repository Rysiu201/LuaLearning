import InventorySlot from './InventorySlot';
import { useAppSelector } from '../../store';
import { selectRightInventory } from '../../store/inventory';

const RightInventory: React.FC = () => {
  const rightInventory = useAppSelector(selectRightInventory);
  const items = rightInventory.items;

  const getItem = (slot: number) =>
    items.find((i) => i.slot === slot) || { slot };

  return (
    <div className="equipment-container">
      <div className="equipment-column">
        <InventorySlot
          item={getItem(1)}
          inventoryType={rightInventory.type}
          inventoryGroups={rightInventory.groups}
          inventoryId={rightInventory.id}
        />
        <InventorySlot
          item={getItem(2)}
          inventoryType={rightInventory.type}
          inventoryGroups={rightInventory.groups}
          inventoryId={rightInventory.id}
        />
        <InventorySlot
          item={getItem(3)}
          inventoryType={rightInventory.type}
          inventoryGroups={rightInventory.groups}
          inventoryId={rightInventory.id}
        />
      </div>
      <div className="equipment-character" />
      <div className="equipment-column">
        <InventorySlot
          item={getItem(4)}
          inventoryType={rightInventory.type}
          inventoryGroups={rightInventory.groups}
          inventoryId={rightInventory.id}
        />
        <InventorySlot
          item={getItem(5)}
          inventoryType={rightInventory.type}
          inventoryGroups={rightInventory.groups}
          inventoryId={rightInventory.id}
        />
        <InventorySlot
          item={getItem(6)}
          inventoryType={rightInventory.type}
          inventoryGroups={rightInventory.groups}
          inventoryId={rightInventory.id}
        />
      </div>
    </div>
  );
};

export default RightInventory;
