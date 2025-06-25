document.addEventListener('DOMContentLoaded', () => {
  const pocketGrid = document.getElementById('pocket-grid');
  const equipSlots = document.querySelectorAll('.equip-grid .slot');
  const wrapper = document.getElementById('inventory-ui');
  const pockets = document.querySelector('.pockets');
  const equipment = document.querySelector('.equipment');
  const hotkeys = document.querySelector('.hotkeys');
  let draggedSlot = null;
  let inventoryOpen = false;
  let tabPreview = false;

  // generate pocket item slots
  const pocketCount = 20;
  for (let i = 0; i < pocketCount; i++) {
    const slot = document.createElement('div');
    slot.className = 'item-slot';
    slot.dataset.slot = `pocket-${i}`;
    slot.dataset.item = '';
    slot.draggable = true;

    const icon = document.createElement('div');
    icon.className = 'icon';
    slot.appendChild(icon);

    const details = document.createElement('div');
    details.className = 'details';
    details.innerHTML = '<span class="name">Item</span><span class="weight">0kg</span><span class="rarity">C</span>';
    slot.appendChild(details);

    pocketGrid.appendChild(slot);
    enableDragAndDrop(slot);
    enableDrop(slot);
  }

  equipSlots.forEach(slot => {
    slot.dataset.item = '';
    slot.draggable = true;
    const details = document.createElement('div');
    details.className = 'details';
    details.innerHTML = '<span class="name">Item</span><span class="weight">0kg</span><span class="rarity">C</span>';
    slot.appendChild(details);
    enableDragAndDrop(slot);
    enableDrop(slot);
  });

  // allow dropping back into pockets
  pocketGrid.querySelectorAll('.item-slot').forEach(enableDrop);

  function enableDragAndDrop(el) {
    el.addEventListener('dragstart', e => {
      draggedSlot = el;
      e.dataTransfer.effectAllowed = 'move';
      el.classList.add('dragging');
    });
    el.addEventListener('dragend', () => {
      el.classList.remove('dragging');
      draggedSlot = null;
    });
  }

  function enableDrop(target) {
    target.addEventListener('dragover', e => {
      e.preventDefault();
    });
    target.addEventListener('drop', e => {
      e.preventDefault();
      if (draggedSlot && target !== draggedSlot) {
        const draggedIcon = draggedSlot.querySelector('.icon');
        const targetIcon = target.querySelector('.icon');
        const draggedClone = draggedIcon.cloneNode(true);
        const targetClone = targetIcon.cloneNode(true);
        draggedSlot.replaceChild(targetClone, draggedIcon);
        target.replaceChild(draggedClone, targetIcon);

        const tmpItem = target.dataset.item;
        target.dataset.item = draggedSlot.dataset.item;
        draggedSlot.dataset.item = tmpItem;
      }
    });
  }

  function showInventory() {
    wrapper.classList.remove('hidden');
    pockets.style.display = '';
    equipment.style.display = '';
    hotkeys.style.display = '';
    document.body.classList.remove('hotkeys-only');
    inventoryOpen = true;
  }

  function hideInventory() {
    wrapper.classList.add('hidden');
    document.body.classList.remove('hotkeys-only');
    inventoryOpen = false;
  }

  function showHotbarOnly() {
    wrapper.classList.remove('hidden');
    pockets.style.display = 'none';
    equipment.style.display = 'none';
    hotkeys.style.display = '';
    document.body.classList.add('hotkeys-only');
    tabPreview = true;
  }

  function hideHotbarOnly() {
    pockets.style.display = '';
    equipment.style.display = '';
    hotkeys.style.display = '';
    document.body.classList.remove('hotkeys-only');
    tabPreview = false;
    if (!inventoryOpen) wrapper.classList.add('hidden');
  }

  window.addEventListener('message', (e) => {
    if (e.data.action === 'showInventory') showInventory();
    if (e.data.action === 'hideInventory') hideInventory();
    if (e.data.action === 'showHotbarOnly') showHotbarOnly();
    if (e.data.action === 'hideHotbarOnly') hideHotbarOnly();
  });

});
