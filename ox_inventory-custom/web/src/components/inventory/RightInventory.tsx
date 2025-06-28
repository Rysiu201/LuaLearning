import React from 'react';
import armourIcon from '../../../images/armour.png?url';
import parachuteIcon from '../../../images/parachute.png?url';
import phoneIcon from '../../../images/phone.png?url';
import weaponIcon from '../../../images/WEAPON_PISTOL.png?url';
import bagIcon from '../../../images/garbage.png?url';

const RightInventory: React.FC = () => {
  return (
    <div className="right-inventory">
      <h2 className="pockets-title">Equipment</h2>
      <div className="equipment-grid">
        <div className="equipment-slot" style={{ gridColumn: 1, gridRow: 1 }}>
          <img src={bagIcon} alt="Backpack" className="equipment-icon" />
        </div>
        <div className="equipment-placeholder" style={{ gridColumn: 2, gridRow: '1 / span 3' }}>
          <span>PLAYER MODEL</span>
        </div>
        <div className="equipment-slot" style={{ gridColumn: 3, gridRow: 1 }}>
          <img src={parachuteIcon} alt="Parachute" className="equipment-icon" />
        </div>
        <div className="equipment-slot" style={{ gridColumn: 1, gridRow: 2 }}>
          <img src={armourIcon} alt="Body Armour" className="equipment-icon" />
        </div>
        <div className="equipment-slot" style={{ gridColumn: 3, gridRow: 2 }}>
          <img src={weaponIcon} alt="Weapon Slot 1" className="equipment-icon" />
        </div>
        <div className="equipment-slot" style={{ gridColumn: 1, gridRow: 3 }}>
          <img src={phoneIcon} alt="Phone" className="equipment-icon" />
        </div>
        <div className="equipment-slot" style={{ gridColumn: 3, gridRow: 3 }}>
          <img src={weaponIcon} alt="Weapon Slot 2" className="equipment-icon" />
        </div>
      </div>
      <div className="hotkey-row">
        <div className="hotkey-slot">
          <span>HOTKEY SLOT 3</span>
          <div className="equipment-slot">
            <img src={weaponIcon} alt="Hotkey Slot 3" className="equipment-icon" />
          </div>
        </div>
        <div className="hotkey-slot">
          <span>HOTKEY SLOT 4</span>
          <div className="equipment-slot">
            <img src={weaponIcon} alt="Hotkey Slot 4" className="equipment-icon" />
          </div>
        </div>
        <div className="hotkey-slot">
          <span>HOTKEY SLOT 5</span>
          <div className="equipment-slot">
            <img src={weaponIcon} alt="Hotkey Slot 5" className="equipment-icon" />
          </div>
        </div>
      </div>
    </div>
  );
};

export default RightInventory;
