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
        <span className={`key-wrapper ${!showEquipment ? 'green' : ''}`}>
          <span className="key-box">Q</span>
        </span>
        Inventory
      </button>
      <button
        type="button"
        className={`tab-btn ${showEquipment ? 'active' : ''}`}
        onClick={() => setShowEquipment(true)}
      >
        <span className={`key-wrapper ${showEquipment ? 'green' : ''}`}>
          <span className="key-box">E</span>
        </span>
        Equipment
      </button>
    </div>
  );
}; 

export default InventoryTabs;
