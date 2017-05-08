xquery version "1.0";

declare variable $courseID as xs:string external;
declare variable $studentList
:= doc('../mezo_students.xml')//student[courses/course[@cID=$courseID]];

<course cID='{$courseID}' enrollment="{count($studentList)}">
{
$studentList
}
</course>
