import { createAsyncThunk } from '@reduxjs/toolkit';
import { fetchNui } from '../utils/fetchNui';

export const buyCart = createAsyncThunk(
  'inventory/buyCart',
  async (
    data: { items: { fromSlot: number; count: number }[]; currency?: string },
    { rejectWithValue }
  ) => {
    try {
      const response = await fetchNui<boolean>('buyCart', data);

      if (response === false) {
        return rejectWithValue(response);
      }
    } catch (error) {
      return rejectWithValue(false);
    }
  }
);

