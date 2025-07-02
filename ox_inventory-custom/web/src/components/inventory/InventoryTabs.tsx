import React from 'react';

interface Props {
  showEquipment: boolean;
  setShowEquipment: React.Dispatch<React.SetStateAction<boolean>>;
}

const InventoryTabs: React.FC<Props> = ({ showEquipment, setShowEquipment }) => {
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
        E Equipment
      </div>
    </div>
  );
};

export default InventoryTabs;
