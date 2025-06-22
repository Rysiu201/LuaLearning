const pockets = document.getElementById('pockets');

// create pocket slots
for (let i = 0; i < 20; i++) {
    const slot = document.createElement('div');
    slot.classList.add('slot');
    slot.id = `pocket-${i}`;
    enableDrag(slot);
    pockets.appendChild(slot);
}

function enableDrag(el) {
    el.draggable = true;
    el.addEventListener('dragstart', e => {
        e.dataTransfer.setData('text/plain', el.id);
    });
}

function handleDrop(e) {
    e.preventDefault();
    const id = e.dataTransfer.getData('text/plain');
    const dragged = document.getElementById(id);
    if (dragged && e.currentTarget !== dragged) {
        e.currentTarget.appendChild(dragged);
    }
}

function handleDragOver(e) {
    e.preventDefault();
}

// apply handlers to all slots
document.querySelectorAll("#figure .slot").forEach(enableDrag);
function bindSlots() {
    document.querySelectorAll('.slot').forEach(slot => {
        slot.addEventListener('dragover', handleDragOver);
        slot.addEventListener('drop', handleDrop);
    });
}

bindSlots();
