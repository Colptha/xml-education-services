xquery version "1.0";

declare variable $courses := doc('../mezo_courses.xml')//course;

<courseRevenueByWeek>
{
  for $c in $courses

  let $weeklyRevenue := $c/((enrollment * price) div weeks)

  order by $weeklyRevenue descending

  return
    <course id="{$c/@cID}">
      <weeklyRevenue>{format-number($weeklyRevenue, '$#,##0.00')}</weeklyRevenue>
    </course>
}
</courseRevenueByWeek>
