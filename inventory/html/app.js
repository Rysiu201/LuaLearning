const pocketContainer = document.getElementById('pockets');
const itemTemplate = document.getElementById('item-template');
const slots = document.querySelectorAll('.slot');

// generate some sample pocket items
for (let i = 0; i < 20; i++) {
    const node = itemTemplate.content.firstElementChild.cloneNode(true);
    node.querySelector('img').src = '';
    node.querySelector('.label').textContent = 'Item ' + (i+1);
    node.dataset.id = `item-${i}`;
    addDragHandlers(node);
    pocketContainer.appendChild(node);
}

slots.forEach(slot => {
    slot.addEventListener('dragover', e => e.preventDefault());
    slot.addEventListener('drop', onDrop);
});

function addDragHandlers(item) {
    item.addEventListener('dragstart', () => {
        item.classList.add('dragging');
    });
    item.addEventListener('dragend', () => {
        item.classList.remove('dragging');
    });
}

function onDrop(e) {
    e.preventDefault();
    const dragged = document.querySelector('.dragging');
    if (dragged) {
        e.currentTarget.appendChild(dragged);
    }
}

pocketContainer.addEventListener('dragover', e => e.preventDefault());
pocketContainer.addEventListener('drop', onDrop);
