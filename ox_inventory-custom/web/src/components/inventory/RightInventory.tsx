import React from 'react';
import armourIcon from '../../../images/armour.png?url';
import parachuteIcon from '../../../images/parachute.png?url';
import phoneIcon from '../../../images/phone.png?url';
import weaponIcon from '../../../images/WEAPON_PISTOL.png?url';
import bagIcon from '../../../images/garbage.png?url';
import characterGrid from '../../../images/character_grid.png?url';
import InventorySlot from './InventorySlot';
import { useAppSelector } from '../../store';
import { selectEquipmentInventory } from '../../store/inventory';
import { isSlotWithItem } from '../../helpers';

const RightInventory: React.FC = () => {
  const player = useAppSelector(selectEquipmentInventory);
  const groups = player.groups;
  const getItem = (slot: number) => player.items[slot - 1] || { slot };

  return (
    <div className="right-inventory">
      <h2 className="pockets-title">Equipment</h2>
      <div className="equipment-grid">
        <div className="slot-wrapper" style={{ gridColumn: 1, gridRow: 1 }}>
          <span>BACKPACK</span>
          <div className="equipment-slot">
            {!isSlotWithItem(getItem(6)) && (
              <img src={bagIcon} alt="Backpack" className="equipment-icon" />
            )}
            <InventorySlot
              item={getItem(6)}
              inventoryId={player.id}
              inventoryType={player.type}
              inventoryGroups={groups}
              showHotkeyNumber={false}
            />
          </div>
        </div>
        <div className="equipment-placeholder" style={{ gridColumn: 2, gridRow: '1 / span 3' }}>
          <img src={characterGrid} alt="Player Model" className="character-grid" />
        </div>
        <div className="slot-wrapper right-shift" style={{ gridColumn: 3, gridRow: 1 }}>
          <span>PARACHUTE</span>
          <div className="equipment-slot">
            {!isSlotWithItem(getItem(9)) && (
              <img src={parachuteIcon} alt="Parachute" className="equipment-icon" />
            )}
            <InventorySlot
              item={getItem(9)}
              inventoryId={player.id}
              inventoryType={player.type}
              inventoryGroups={groups}
              showHotkeyNumber={false}
            />
          </div>
        </div>
        <div className="slot-wrapper" style={{ gridColumn: 1, gridRow: 2 }}>
          <span>ARMOUR</span>
          <div className="equipment-slot">
            {!isSlotWithItem(getItem(7)) && (
              <img src={armourIcon} alt="Body Armour" className="equipment-icon" />
            )}
            <InventorySlot
              item={getItem(7)}
              inventoryId={player.id}
              inventoryType={player.type}
              inventoryGroups={groups}
              showHotkeyNumber={false}
            />
          </div>
        </div>
        <div className="slot-wrapper right-shift" style={{ gridColumn: 3, gridRow: 2 }}>
          <span>WEAPON 1</span>
          <div className="equipment-slot">
            {!isSlotWithItem(getItem(1)) && (
              <img src={weaponIcon} alt="Weapon Slot 1" className="equipment-icon" />
            )}
            <InventorySlot
              item={getItem(1)}
              inventoryId={player.id}
              inventoryType={player.type}
              inventoryGroups={groups}
              showHotkeyNumber
            />
          </div>
        </div>
        <div className="slot-wrapper" style={{ gridColumn: 1, gridRow: 3 }}>
          <span>PHONE</span>
          <div className="equipment-slot">
            {!isSlotWithItem(getItem(8)) && (
              <img src={phoneIcon} alt="Phone" className="equipment-icon" />
            )}
            <InventorySlot
              item={getItem(8)}
              inventoryId={player.id}
              inventoryType={player.type}
              inventoryGroups={groups}
              showHotkeyNumber={false}
            />
          </div>
        </div>
        <div className="slot-wrapper right-shift" style={{ gridColumn: 3, gridRow: 3 }}>
          <span>WEAPON 2</span>
          <div className="equipment-slot">
            {!isSlotWithItem(getItem(2)) && (
              <img src={weaponIcon} alt="Weapon Slot 2" className="equipment-icon" />
            )}
            <InventorySlot
              item={getItem(2)}
              inventoryId={player.id}
              inventoryType={player.type}
              inventoryGroups={groups}
              showHotkeyNumber
            />
          </div>
        </div>
      </div>
      <div className="hotkey-row">
        <div className="hotkey-slot">
          <span>HOTKEY SLOT 3</span>
          <div className="equipment-slot">
            {!isSlotWithItem(getItem(3)) && (
              <img src={weaponIcon} alt="Hotkey Slot 3" className="equipment-icon" />
            )}
          <InventorySlot
            item={getItem(3)}
            inventoryId={player.id}
            inventoryType={player.type}
            inventoryGroups={groups}
            showHotkeyNumber
          />
          </div>
        </div>
        <div className="hotkey-slot">
          <span>HOTKEY SLOT 4</span>
          <div className="equipment-slot">
            {!isSlotWithItem(getItem(4)) && (
              <img src={weaponIcon} alt="Hotkey Slot 4" className="equipment-icon" />
            )}
          <InventorySlot
            item={getItem(4)}
            inventoryId={player.id}
            inventoryType={player.type}
            inventoryGroups={groups}
            showHotkeyNumber
          />
          </div>
        </div>
        <div className="hotkey-slot">
          <span>HOTKEY SLOT 5</span>
          <div className="equipment-slot">
            {!isSlotWithItem(getItem(5)) && (
              <img src={weaponIcon} alt="Hotkey Slot 5" className="equipment-icon" />
            )}
          <InventorySlot
            item={getItem(5)}
            inventoryId={player.id}
            inventoryType={player.type}
            inventoryGroups={groups}
            showHotkeyNumber
          />
          </div>
        </div>
      </div>
    </div>
  );
};

export default RightInventory;
