import React from 'react';
import { useAppSelector } from '../../store';
import { selectRightInventory } from '../../store/inventory';
import { InventoryType } from '../../typings';

interface Props {
  showEquipment: boolean;
  setShowEquipment: React.Dispatch<React.SetStateAction<boolean>>;
}

const InventoryTabs: React.FC<Props> = ({ showEquipment, setShowEquipment }) => {
  const rightInventory = useAppSelector(selectRightInventory);

  let equipmentLabel = 'Equipment';
  if (rightInventory.type === InventoryType.CRAFTING) equipmentLabel = 'Crafting';
  else if (rightInventory.type === InventoryType.SHOP) equipmentLabel = rightInventory.label || 'Shop';
  else if (rightInventory.type && rightInventory.type !== InventoryType.PLAYER) equipmentLabel = rightInventory.label || rightInventory.type;

  return (
    <div className="inventory-tabs">
      <div
        className={`tab-btn ${!showEquipment ? 'active' : ''}`}
        onClick={() => setShowEquipment(false)}
      >
        Q Inventory
      </div>
      <div
        className={`tab-btn ${showEquipment ? 'active' : ''}`}
        onClick={() => setShowEquipment(true)}
      >
        E {equipmentLabel}
      </div>
    </div>
  );
};

export default InventoryTabs;
