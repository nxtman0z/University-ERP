function showSection(sectionId) {
    // Hide all sections
    var sections = document.getElementsByClassName('section');
    for (var i = 0; i < sections.length; i++) {
        sections[i].style.display = 'none';
    }
    
    // Show the selected section
    var selectedSection = document.getElementById(sectionId);
    if (selectedSection) {
        selectedSection.style.display = 'block';
    }
}

// Show first section by default when page loads
document.addEventListener('DOMContentLoaded', function() {
    var firstSection = document.querySelector('.section');
    if (firstSection) {
        firstSection.style.display = 'block';
    }
});
