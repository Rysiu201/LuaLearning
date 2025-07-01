import { ItemData } from '../typings/item';

export const Items: {
  [key: string]: ItemData | undefined;
} = {
  water: {
    name: 'water',
    close: false,
    label: 'VODA',
    stack: true,
    usable: true,
    count: 0,
  },
  burger: {
    name: 'burger',
    close: false,
    label: 'BURGR',
    stack: false,
    usable: false,
    count: 0,
  },
  phone: {
    name: 'phone',
    close: false,
    label: 'PHONE',
    stack: false,
    usable: true,
    count: 0,
  },
  armour: {
    name: 'armour',
    close: false,
    label: 'ARMOR',
    stack: false,
    usable: false,
    count: 0,
  },
  paperbag: {
    name: 'paperbag',
    close: false,
    label: 'PAPERBAG',
    stack: false,
    usable: false,
    count: 0,
  },
  parachute: {
    name: 'parachute',
    close: false,
    label: 'PARACHUTE',
    stack: false,
    usable: false,
    count: 0,
  },
  WEAPON_PISTOL: {
    name: 'WEAPON_PISTOL',
    close: false,
    label: 'Pistol',
    stack: false,
    usable: false,
    count: 0,
  },
};
