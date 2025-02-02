self.addEventListener('push', event => {
    const options = {
        body: event.data.text(),
        icon: '/images/icon.png',
        badge: '/images/badge.png',
        vibrate: [100, 50, 100],
        data: {
            dateOfArrival: Date.now(),
            primaryKey: '1'
        },
        actions: [
            {
                action: 'view',
                title: 'View Details'
            }
        ]
    };

    event.waitUntil(
        self.registration.showNotification('Attendify', options)
    );
});

self.addEventListener('notificationclick', event => {
    event.notification.close();
    if (event.action === 'view') {
        clients.openWindow('/student-dashboard.html');
    }
});