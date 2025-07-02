import React from 'react';

interface Props {
  showEquipment: boolean;
  setShowEquipment: React.Dispatch<React.SetStateAction<boolean>>;
}

const InventoryTabs: React.FC<Props> = ({ showEquipment, setShowEquipment }) => {
  return (
    <div className="inventory-tabs">
      <button
        type="button"
        className={`tab-btn ${!showEquipment ? 'active' : ''}`}
        onClick={() => setShowEquipment(false)}
      >
        Q Inventory
      </button>
      <button
        type="button"
        className={`tab-btn ${showEquipment ? 'active' : ''}`}
        onClick={() => setShowEquipment(true)}
      >
        E Equipment
      </button>
    </div>
  );
};

export default InventoryTabs;
