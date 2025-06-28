import React from 'react';

const RightInventory: React.FC = () => {
  return (
    <div className="right-inventory">
      <h2 className="pockets-title">Pockets</h2>
      <div className="equipment-grid">
        <div className="equipment-slot" style={{ gridColumn: 1, gridRow: 1 }}>
          Backpack
        </div>
        <div className="equipment-placeholder" style={{ gridColumn: 2, gridRow: '1 / span 3' }}>
          <span>PLAYER MODEL</span>
        </div>
        <div className="equipment-slot" style={{ gridColumn: 3, gridRow: 1 }}>
          Parachute
        </div>
        <div className="equipment-slot" style={{ gridColumn: 1, gridRow: 2 }}>
          Body Armour
        </div>
        <div className="equipment-slot" style={{ gridColumn: 3, gridRow: 2 }}>
          Weapon Slot 1
        </div>
        <div className="equipment-slot" style={{ gridColumn: 1, gridRow: 3 }}>
          Phone
        </div>
        <div className="equipment-slot" style={{ gridColumn: 3, gridRow: 3 }}>
          Weapon Slot 2
        </div>
      </div>
    </div>
  );
};

export default RightInventory;
