<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json"); 
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization"); 
include 'db_connection.php';

$sql = "
SELECT 
    person.person_id,
    person.name,
    YEARWEEK(sales.sale_date, 1) AS year_week,
    SUM(sales.qty) AS total_sales,
    CASE 
        WHEN SUM(sales.qty) > 10 THEN CONCAT('Yes 😊')
        ELSE 'No'
    END AS exceeded_10
FROM 
    person
INNER JOIN 
    sales 
ON 
    person.person_id = sales.person_id
GROUP BY 
    year_week, person.person_id, person.name
ORDER BY 
    year_week ASC, total_sales DESC
";

$result = $conn->query($sql);

$data = [];
while ($row = $result->fetch_assoc()) {
    $data[$row['year_week']][] = $row;
}

$conn->close();

echo json_encode($data);
?>
