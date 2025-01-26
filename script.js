document.addEventListener('DOMContentLoaded', () => {
    fetch('http://localhost:8000/fetch_sales.php')
        .then(response => response.json())
        .then(data => {
            const container = document.querySelector('#tables-container');
            container.innerHTML = '';

            for (const [week, sales] of Object.entries(data)) {
                const heading = document.createElement('h3');
                heading.textContent = `Vecka ${week}`;
                heading.className = 'text-primary';

                const table = document.createElement('table');
                table.className = 'table table-striped table-bordered';

                table.innerHTML = `
                    <thead class="table-dark">
                        <tr>
                            <th>Person ID</th>
                            <th>Namn</th>
                            <th>År/Vecka</th>
                            <th>Totalt Sålt</th>
                            <th>Översteg 10?</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${sales
                            .map(
                                sale => `
                            <tr>
                                <td>${sale.person_id}</td>
                                <td>${sale.name}</td>
                                <td>${sale.year_week}</td>
                                <td>${sale.total_sales}</td>
                                <td>${sale.exceeded_10}</td>
                            </tr>
                        `
                            )
                            .join('')}
                    </tbody>
                `;

                const col = document.createElement('div');
                col.className = 'col-12';
                col.appendChild(heading);
                col.appendChild(table);

                container.appendChild(col);
            }
        })
        .catch(error => console.error('Error fetching sales data:', error));
});
