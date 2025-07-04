# ☀️ Solar Data Dashboard

Solar Data Dashboard is a browser-based tool for visualizing CSV data exported from MyEnergi products. It allows you to track and analyze solar energy generation, net grid import/export, and other metrics — all from a simple, elegant web interface.

<!-- Optional: add a screenshot image of the UI -->

## 🔧 Features

📈 Interactive Charting via Chart.js
📁 CSV Upload Support (MyEnergi format, including Eddi and inverter data)
🧠 Smart Filtering by Day, Week, Month, or All Time
💡 Real-time Data Parsing with PapaParse
🌙 Dark UI Theme built with Tailwind CSS
⚡ Fast, standalone — No server required
🚀 Getting Started

1. Clone or Download
git clone git@github.com:mhefner/myenergi_solar_dashboard.git
cd solar-data-dashboard
Or just download the index.html file and open it in your browser.

2. Open the Dashboard
Double-click index.html or open it in your browser of choice (Chrome/Firefox/Safari/etc).

3. Upload Your CSV File
Export a CSV from your MyEnergi device portal (e.g., Eddi, Zappi, etc.), then click "Upload Your CSV File" and select it. The dashboard will automatically parse and display the data.

## 📊 Data Requirements

The CSV file should include the following headers (or a compatible superset):

Timestamp
Total Generation (Wh)
Net Grid Import (Wh)
Net Grid Export (Wh)
Other fields are supported but optional.

The dashboard uses the timestamp field to generate time-based charts of:

Solar Generation
Grid Import
Grid Export
🧱 Tech Stack

HTML5 / CSS3 / JavaScript
Tailwind CSS
Chart.js
PapaParse
Google Fonts – Inter
🛠 Development Notes

No build tools required — this is a self-contained static web app. You can extend it to support:

Data aggregation (daily/weekly summaries)
Additional metrics like voltage/frequency
PWA support or offline caching
Server-side CSV ingestion and persistence
📁 Folder Structure

solar-data-dashboard/
├── index.html           # Main application file
└── README.md            # You are here
🧪 Example CSV

Sample data is embedded in the HTML by default so you can explore the dashboard without uploading a file. This can be replaced or disabled as needed.

📜 License

MIT License — feel free to use, modify, or redistribute. Attribution appreciated.

💬 Credits

Made with ☕ by [mhefner]
Uses data from MyEnergi products and services.
