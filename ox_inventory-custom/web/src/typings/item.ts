export type ItemData = {
  name: string;
  label: string;
  stack: boolean;
  usable: boolean;
  close: boolean;
  count: number;
  description?: string;
  buttons?: string[];
  ammoName?: string;
  image?: string;
  rarity?: 'Common' | 'Uncommon' | 'Rare' | 'Epic' | 'Legendary';
  metadata?: {
    quality?: 'Common' | 'Uncommon' | 'Rare' | 'Epic' | 'Legendary';
    [key: string]: any;
  };
};
