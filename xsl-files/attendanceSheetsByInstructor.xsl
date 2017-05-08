<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"
    doctype-system="about:legacy-compat"
    encoding="UTF-8"
    indent="yes" />

    <xsl:variable name="instructorID"
      select="'I01'" />
    <xsl:variable name="courseList"
      select="document('../xml-source/courses.xml')" />
    <xsl:variable name="instructorList"
      select="document('../xml-source/instructors.xml')//instructor" />
    <xsl:variable name="studentList"
      select="document('../xml-source/students.xml')//student" />
    <xsl:variable name="currentInstructor"
      select="$instructorList[@iID=$instructorID]" />


    <xsl:template name="list">
      <html lang="en">
        <head>
          <meta charset="utf-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
          <title>Attendance Sheets</title>

          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous" />

        </head>
        <body>

          <div class="container">
            <div class="row title">
              <h1>Instructor: <xsl:value-of
                select="concat($currentInstructor/firstName, ' ', $currentInstructor/lastName)" /></h1>
            </div>

            <xsl:for-each select="$courseList//course[instructor[@iID=$instructorID]]">

              <header class="row">
                <div class="col">
                  <h2>Course ID: <xsl:value-of select="current()/@cID" /></h2>
                </div>
                <div class="col">
                  <h2>Number of Students: <xsl:value-of select="current()/enrollment" /></h2>
                </div>
              </header>
              <section class="row">
                <xsl:apply-templates select="." />
              </section>



            </xsl:for-each>

          </div>

          <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
        </body>
      </html>
    </xsl:template>

    <xsl:template match="course">
      <div class="row">
        <xsl:variable name="studentsInCourse"
          select="$studentList[courses/course[@cID=current()/@cID]]" />

        <table class="table table-striped table-bordered">
          <thead class="thead-default">
            <tr>
              <th>Last Name</th>
              <th>First Name</th>
              <th>Week 1</th>
              <th>Week 2</th>
              <th>Week 3</th>
              <th>Week 4</th>
              <th>Week 5</th>
              <th>Week 6</th>
              <th>Week 7</th>
              <th>Week 8</th>
              <th>Week 9</th>
              <th>Week 10</th>
            </tr>
          </thead>
          <tbody>
              <xsl:for-each select="$studentsInCourse">
                <xsl:sort select="./lastName"/>
                <tr>
                  <td><xsl:value-of select="lastName" /></td>
                  <td><xsl:value-of select="firstName" /></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
              </xsl:for-each>
          </tbody>
        </table>
      </div>
    </xsl:template>

</xsl:stylesheet>
