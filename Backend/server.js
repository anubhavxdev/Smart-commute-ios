const express = require('express');
const cors = require('cors');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

// Mock Data
const user = {
    id: 'user_123',
    name: 'Jane Doe',
    email: 'test@example.com'
};

const rides = [
    {
        id: 'ride_001',
        destination: 'Koramangala 5th Block',
        pickupLocation: 'HSR Layout',
        time: new Date(Date.now() + 3600 * 1000).toISOString(),
        driverName: 'John Doe',
        status: 'Upcoming'
    },
    {
        id: 'ride_002',
        destination: 'Indiranagar Metro',
        pickupLocation: 'Koramangala 5th Block',
        time: new Date(Date.now() - 86400 * 1000).toISOString(),
        driverName: 'Raju',
        status: 'Completed'
    },
    {
        id: 'ride_003',
        destination: 'Airport',
        pickupLocation: 'Indiranagar',
        time: new Date(Date.now() - 86400 * 2000).toISOString(),
        driverName: 'Manjesh',
        status: 'Completed'
    }
];

// POST /login
app.post('/login', (req, res) => {
    const { email, password } = req.body;
    
    if (!email || !password) {
        return res.status(400).json({ error: 'Email and password are required.' });
    }
    
    // Simulate latency
    setTimeout(() => {
        res.status(200).json({ 
            success: true, 
            user: { 
                id: 'user_' + Date.now(), 
                name: email.split('@')[0], 
                email: email 
            } 
        });
    }, 1500); 
});

// GET /rides
app.get('/rides', (req, res) => {
    // Simulate latency
    setTimeout(() => {
        res.status(200).json(rides);
    }, 500);
});

app.listen(PORT, () => {
    console.log(`Rapido-like Backend running on http://localhost:${PORT}`);
});
