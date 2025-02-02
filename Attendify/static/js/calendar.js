document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        events: [
            // Sample events
            { title: 'Class A', start: '2025-01-15' },
            { title: 'Class B', start: '2025-01-20' }
        ]
    });

    calendar.render();
});