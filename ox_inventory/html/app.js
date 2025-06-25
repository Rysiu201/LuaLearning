document.addEventListener('DOMContentLoaded', () => {
  const pocketGrid = document.getElementById('pocket-grid');
  const equipSlots = document.querySelectorAll('.equip-grid .slot');
  let draggedSlot = null;

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

    pocketGrid.appendChild(slot);
    enableDragAndDrop(slot);
    enableDrop(slot);
  }

  equipSlots.forEach(slot => {
    slot.dataset.item = '';
    slot.draggable = true;
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
});
