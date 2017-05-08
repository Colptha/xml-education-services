<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"
    doctype-system="about:legacy-compat"
    encoding="UTF-8"
    indent="yes" />

    <xsl:variable name="courseList"
      select="document('../xml-source/courses.xml')" />
    <xsl:variable name="instructorList"
      select="document('../xml-source/instructors.xml')" />
    <xsl:variable name="studentList"
      select="document('../xml-source/students.xml')" />

    <xsl:template name="list">
      <html lang="en">
        <head>
          <meta charset="utf-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
          <title>Class Stats</title>

          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous" />
          <style>
            .hide {
              display: none;
            }
            .grouping {
              margin-top: 50px;
              margin-bottom: 25px;
            }
            header.row {
              background-color: rgba(0, 0, 0, .3);
              border: 3px solid black;
              border-radius: 15px;
              margin: 15px 0;
            }
            h2 {
              padding: 1.5em 1em;
            }
            h3 {
              margin: .25em auto;
              padding: 1em .5em;
              border: 2px solid green;
              border-radius: 10px;
              background-color: rgba(0, 100, 0, .3);
            }
            h4 {
              margin-left: 1em;
            }
            .title {
            margin: 3em 0 .5em 0;
            }
          </style>
        </head>
        <body>

          <div class="container">
            <div class="row title">
              <h1>Class Statistics</h1>
            </div>
            <div class="row">
              <h4>(Click block for details)</h4>
            </div>

            <xsl:for-each-group select="$courseList//course"
              group-by="topic">

              <header class="row {current-grouping-key()}">
                <div class="col">
                  <h2 class="{current-grouping-key()}">Topic: <xsl:value-of select="current-grouping-key()" /></h2>
                </div>
                <div class="col">
                  <h2 class="{current-grouping-key()}">Number of Courses: <xsl:value-of select="count(current-group())" /></h2>
                </div>
              </header>

              <section id="{current-grouping-key()}" class="hide">

                <xsl:apply-templates select="current-group()">
                  <xsl:sort select="@cID" />
                </xsl:apply-templates>

              </section>
              <script>
                var header = document.querySelector(".<xsl:value-of select="current-grouping-key()" />");
                header.addEventListener('click', toggle, false);

                function toggle(e) {
                  var clickedElement = e.target;
                  console.log(clickedElement);
                  var sectionID = clickedElement.classList[0];
                  console.log(sectionID);
                  var section = document.getElementById('' + sectionID);
                  console.log(section);

                  if (section.classList.contains("hide")) {
                    section.classList.remove("hide");
                  } else {
                    section.classList.add("hide");
                  }
                  console.log("I am being clicked!")
                }
              </script>

            </xsl:for-each-group>

          </div>

          <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
        </body>
      </html>
    </xsl:template>

    <xsl:template match="course">

      <xsl:variable name="instructorSalary" select="$instructorList//instructor/salary" />
      <xsl:variable name="personnelCost" select="($instructorSalary div 52) * weeks" />
      <xsl:variable name="revenue" select="enrollment * price" />

      <div class="row grouping">

        <div class="col">
          <div class="row">
            <h3>Course ID: <xsl:value-of select="@cID" /></h3>
          </div>
          <div class="row">
            <dl>
              <dt>Instructor</dt>
              <dd><xsl:value-of select="current()/instructor"/></dd>
            </dl>
          </div>

          <div class="row">
            <dl>
              <dt>Course Price</dt>
              <dd><xsl:value-of select="price" /></dd>
            </dl>
          </div>

          <div class="row">
            <dl>
              <dt>Duration</dt>
              <dd><xsl:value-of select="concat(weeks, ' weeks')" /></dd>
            </dl>
          </div>

          <div class="row">
            <dl>
              <dt>Class Revenue</dt>
              <dd>
                <xsl:value-of
                select="format-number((enrollment * price), '$#,##0.00')" /></dd>
            </dl>
          </div>

          <div class="row">
            <dl>
              <dt>Personnel Expenditures</dt>
              <dd>
                <xsl:value-of
                select="format-number($personnelCost, '$#,##0.00')" /></dd>
            </dl>
          </div>

          <div class="row">
            <dl>
              <dt>Revenue/Expense</dt>
              <dd><xsl:value-of select="$revenue div $personnelCost" /></dd>
            </dl>
          </div>

          <div class="row">
            <p>These statistics are based upon the evaluation of individual courses and only provide profitability metrics given personnel teaching one class at one time. While this is useful to determining the value of teaching particular courses, profit by employee would include in its consideration all classes an employee teaches concurrently.</p>
          </div>

        </div>

        <div class="col">
            <table class="table table-striped table-hover">
              <thead class="thead-inverse">
                <tr>
                  <th>#</th>
                  <th>Last Name</th>
                  <th>First Name</th>
                  <th>Total Courses</th>
                </tr>
              </thead>
              <tbody>

                <xsl:apply-templates select="@cID" />

              </tbody>
            </table>
        </div>

      </div>
    </xsl:template>

    <xsl:template match="@cID">
      <xsl:variable name="studentsInCourse" select="$studentList/students//student[courses/course[@cID=current()]]" />

      <xsl:for-each select="$studentsInCourse">
        <xsl:sort select="./lastName" />
        <tr>
          <th><xsl:value-of select="position()" /></th>
          <td><xsl:value-of select="./lastName" /></td>
          <td><xsl:value-of select="./firstName" /></td>
          <td><xsl:value-of select="count(.//course)" /></td>
        </tr>
      </xsl:for-each>

    </xsl:template>

</xsl:stylesheet>
