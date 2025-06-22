document.addEventListener('DOMContentLoaded', () => {
  const pocketGrid = document.getElementById('pocket-grid');
  const figureSlots = document.querySelectorAll('.figure .slot');

  // generate pocket item slots
  const pocketCount = 20;
  for (let i = 0; i < pocketCount; i++) {
    const slot = document.createElement('div');
    slot.className = 'item-slot';
    slot.dataset.slot = `pocket-${i}`;
    slot.draggable = true;
    pocketGrid.appendChild(slot);
    enableDragAndDrop(slot);
  }

  figureSlots.forEach(slot => {
    slot.draggable = true;
    enableDragAndDrop(slot);
    enableDrop(slot);
  });

  // allow dropping back into pockets
  pocketGrid.querySelectorAll('.item-slot').forEach(enableDrop);

  function enableDragAndDrop(el) {
    el.addEventListener('dragstart', e => {
      e.dataTransfer.setData('text/plain', el.dataset.slot);
      e.dataTransfer.effectAllowed = 'move';
      el.classList.add('dragging');
    });
    el.addEventListener('dragend', () => {
      el.classList.remove('dragging');
    });
  }

  function enableDrop(target) {
    target.addEventListener('dragover', e => {
      e.preventDefault();
    });
    target.addEventListener('drop', e => {
      e.preventDefault();
      const id = e.dataTransfer.getData('text/plain');
      const dragged = document.querySelector(`[data-slot="${id}"]`);
      if (dragged && target !== dragged) {
        target.appendChild(dragged);
      }
    });
  }
});
