'use strict';

function toggleMenu(target) {
    let submenu =  target.parentElement.nextElementSibling;
    if (submenu.style.display === 'none') 
    {
        target.style.transform = 'rotate(180deg)';
        submenu.style.display = 'block';
        // submenu.style.height = 'auto';
    } else {
        target.style.transform = 'rotate(0)';
        submenu.style.display = 'none';
        // submenu.style.height = '0';
    }
    
}