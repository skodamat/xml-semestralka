'use strict';

function toggleMenu(target) {
    let submenu =  target.parentElement.nextElementSibling;
    if (submenu.style.visibility === 'hidden') 
    {
        target.style.transform = 'rotate(180deg)';
        submenu.style.visibility = 'visible';
        submenu.style.height = 'auto';
    } else {
        target.style.transform = 'rotate(0)';
        submenu.style.visibility = 'hidden';
        submenu.style.height = '0';
    }
    
}