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
        className={`tab-btn key-wrapper ${!showEquipment ? 'green active' : ''}`}
        onClick={() => setShowEquipment(false)}
      >
        <span className="key-box">Q</span>
        <span className="key-label">Inventory</span>
      </button>
      <button
        type="button"
        className={`tab-btn key-wrapper ${showEquipment ? 'green active' : ''}`}
        onClick={() => setShowEquipment(true)}
      >
        <span className="key-box">E</span>
        <span className="key-label">Equipment</span>
      </button>
    </div>
  );
}; 

export default InventoryTabs;
