<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"
    doctype-system="about:legacy-compat"
    encoding="UTF-8"
    indent="yes" />

    <xsl:variable name="courseList"
      select="document('../xml-source/courses.xml')//course" />
    <xsl:variable name="instructorList"
      select="document('../xml-source/instructors.xml')//instructor" />
    <xsl:variable name="studentList"
      select="document('../xml-source/students.xml')//student" />

    <xsl:template name="list">
      <html lang="en">
        <head>
          <meta charset="utf-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
          <title>Computations</title>

          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous" />

        </head>
        <body>

          <div class="container">

            <div class="row title">
            </div>

            <xsl:for-each select="$instructorList">

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

    <xsl:template match="instructor">
      <xsl:variable name="instructorCourses"
        select="$courseList[instructor[@iID=current()/@iID]]" />
        <xsl:variable name="totalGross"
          select="sum($instructorCourses/(price * enrollment))" />

      <div class="col-sm-4">
        <h1><xsl:value-of select="concat(./firstName, ' ', ./lastName)"/></h1>
      </div>
      <div class="col-sm-8">

        <div class="row">
          <div class="col-sm-8">
            <h2>Number of classes taught</h2>
          </div>
          <div class="col-sm-4">
            <h3><xsl:value-of select="count($instructorCourses)"/></h3>
          </div>
        </div>



        <table class="table table-striped">
          <thead>
            <tr>
              <th colspan="2">Class</th>
              <th>Gross</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="$instructorCourses">
              <tr>
                <td>
                  <xsl:value-of select="concat(current()/topic, ': ', current()/@cID)"/>
                </td>
                <td>Subtotal</td>
                <td>
                  <xsl:value-of
                    select="format-number(current()/(price * enrollment), '$#,##0.00')"/>
                </td>
              </tr>
            </xsl:for-each>
            <tr>
              <th scope="row" colspan="2">Total Gross</th>
              <th scope="col">
                <xsl:value-of
                  select="format-number($totalGross,'$#,##0.00')" />
              </th>
            </tr>
            <tr>
              <th scope="row" colspan="2">
                Average Per Class
              </th>
              <th scope="col">
                <xsl:value-of
                  select="format-number(
                  sum($instructorCourses/(price * enrollment))
                  div count($instructorCourses),
                  '$#,##0.00')" />
              </th>
            </tr>
            <tr>
              <th scope="row" colspan="2">
                Average Per Week
              </th>
              <th scope="col">
                <xsl:variable name="totalWeeks"
                  select="sum($instructorCourses/weeks)" />

                <xsl:value-of select="format-number(
                  $totalGross div $totalWeeks, '$#,##0.00'
                  )"/>
              </th>
            </tr>
          </tbody>
        </table>

      </div>
    </xsl:template>

</xsl:stylesheet>
