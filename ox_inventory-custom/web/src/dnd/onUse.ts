//import toast from "react-hot-toast";
import { fetchNui } from '../utils/fetchNui';
import { Slot } from '../typings';

export const onUse = (item: Slot) => {
  if (
    item.name === 'backpack1' ||
    item.name === 'backpack2' ||
    item.name === 'backpack3' ||
    item.name === 'backpack4' ||
    item.name === 'backpack5'
  )
    return;
  //toast.success(`Use ${item.name}`);
  fetchNui('useItem', item.slot);
};
