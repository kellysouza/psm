# DESIGN.md

***NOTE: 2017-07-03: This document is still very much a work in
   progress.  We welcome suggestions on improving it.***

## Overall architecture

The Provider Screening Module is a Java EE Enterprise Application
using [Gradle](https://gradle.org/) to manage builds, [the Spring
framework](http://projects.spring.io/spring-framework/) for core web
application functionality (including providing an API),
[Hibernate](http://hibernate.org/) for Object Relational Mapping
(interacting with the database), and [jBPM](http://www.jbpm.org/) and
[Drools](http://drools.org/) for business rules management. See
[`DEPENDENCIES.md`](DEPENDENCIES.md) and [`INSTALL.md`](INSTALL.md)
for more details on component versions and installation requirements.

Within the PSM codebase are several "projects" within the `psm-app`
directory. The major ones are:

* `cms-business-model` (contains XML-defined Java data types, e.g.,
  license type)

* `cms-business-process` (includes callbacks into Java from jBPM)

* `cms-services` (includes Hibernate entities, binders that map
  frontend elements to Java handles, definitions of EE services that
  `cms-business-process` implements)

* `cms-web` (MVC, web controller, frontend, UI)

* `cms-portal-services` (generates EAR file, and is where TopCoder JAR
  files live)

* `userhelp` (contains prose documents for end user help)

A diagram of the components mentioned above is available at
[`docs/psm-architecture-for-stakeholders.pdf`](psm-architecture-for-stakeholders.pdf).

## Workflow for processing submissions

See
[`psm-app/cms-business-process/src/main/resources/EnrollmentProcess.png`](../psm-app/cms-business-process/src/main/resources/EnrollmentProcess.png)
for a diagrammatic representation of the jBPM workflow defined in
`psm-app/cms-business-process/src/main/resources/EnrollmentProcess.bpmn`.


## UI Templates

Originally, the PSM used
[JSP](http://www.caucho.com/resin-3.1/doc/jsp-templates.xtp) templates,
as detailed in [issue
#238](https://github.com/OpenTechStrategies/psm/issues/238#issuecomment-313217566).
We have converted some of these JSP templates to
[Handlebars](http://handlebarsjs.com/), for easier reuse.  Handlebars
templates can be used with code written in any number of languages, not
just Java.  For this reason, they are not as exactly tuned to Java
development.  JSPs are able to hold more complex logic than Handlebars,
and work well for the PSM's screens, which are so specific that they are
unlikely to be reused.  The framing templates of the PSM (the headers,
footers, and navigation bar) have been converted to Handlebars, since they
are the most likely to be reused in other applications or in pieces of
the PSM that might be written in another language.

As part of this conversion, we deduplicated many of the templates.  When
you are editing a piece of UI functionality, it should appear in either
a JSP template or a Handlebars template.  Use the correct formatting for
whichever style applies.

See [handlebars.md](handlebars.md) for more detail about this conversion
process.

## Interfaces

***NOTE:2017-07-03: [We no longer use `ext-sources-app` and are
   rewriting this section
   accordingly.](https://github.com/SolutionGuidance/psm/issues/165).***

The two pieces of this application (`psm-app` and `ext-sources-app`)
communicate via a web service which is provided by the `ext-sources-app`.
Let's call that the External Sources Services (ESS).  The ESS takes
return XML, which is handled by
[javax.jws](http://docs.oracle.com/javaee/5/api/javax/jws/package-summary.html)
(this takes serializable Java objects and converts them to XML).

Take `AccreditedBirthCentersLicenseService` as a typical example of these
web services:

The client steps are marked CLIENT below -- paths referenced in these
items are all rooted on `psm-app`.  The ESS steps are marked ESS -- paths
referenced in these items are all rooted on `ext-sources-app`.

1.  CLIENT: The core application defines the interactions with the
    service in `cms.externalsources.drl`
    (`cms-business-processes/src/main/resources/cms.externalsources.drl`)

2.  CLIENT:  The request parameters are translated to XML before being sent to
    the server, the translation is defined in
    `accredited_birth_center_req.xml`
    (`services/src/main/resources/xslt/accredited_birth_center_res.xsl`)

3.  ESS: The request arrives at the appropriate endpoint.  The endpoint has
    been defined in `cxf-servlet.xml`
    (`startup-war/WebContent/WEB-INF/cxf-servlet.xml`  lines 14-17)

4.  ESS: The request is translated from XML to parameters and routed to the
    service implementation (also defined in `cxf-servlet`) which is defined
    in `AccreditedBirthCentersLicenseServiceImpl.java`
    (`services/src/main/java/gov/medicaid/screening/services/impl/AccreditedBirthCentersLicenseServiceImpl.java`)

5.  ESS: The service calls the DAO which handles the search itself.  In this
    case `AccreditedBirthCentersLicenseDAOBean.java`
    (`services/src/main/java/gov/medicaid/screening/dao/impl/AccreditedBirthCentersLicenseDAOBean.java`)
    -- this hits up the third party service to try to pull down data.
    
6.  ESS: The result is passed as a simple POJO (Plain Old Java Object),
    whose structure is defined in `AccreditedBirthCenter.java`
    (`services/src/main/java/gov/medicaid/entities/AccreditedBirthCenter.java`)
    
7.  ESS: The POJO is converted to XML by basic Java libraries
    (`javax.jws`), and then returned back to the client.

8.  CLIENT: The client translates the XML into a POJO via
    `accredited_birth_center_res.xsl`
    (`psm-app/services/src/main/resources/xslt/accredited_birth_center_res.xsl`)

There is no documentation of the data structures yet.  The other
services all appear to follow a similar pattern in the structure of the
application.  Each POJO for each endpoint is unique; they share no
common superclass.

This all means that the API is currently brittle; it hasn't been
engineered or documented (see [this
milestone](https://github.com/SolutionGuidance/psm/milestone/4)), and
writing a client for it isn't predictable (you would have to look at the
POJO to know what kind of return to expect).

The `ejb-jar.xml` file is used within ESS functionality, not for the
actual webservice definition.  It defines the custom URL config
parameter (`mita/config/URL`) so that it contains the URL of that bean's
associated third party application.  That variable is used in the DAO's
superclass
(`services/src/main/java/gov/medicaid/screening/dao/impl/BaseDAO.java` --
see line 102) which uses it to make the actual call to the external
service.  In the case of our AccreditedBirthCenters the
`ext-sources-app/services/src/main/resources/META-INF/ejb-jar.xml` defines
the service as
[http://www.birthcenteraccreditation.org/find-accredited-birth-centers](http://www.birthcenteraccreditation.org/find-accredited-birth-centers).


## User types

The PSM has four types of users, each with their own permission level:

1. __Service agent__
    
    Service agents should be able to create, view, and edit enrollments
    for their provider clients.

    - Can view: provider dashboard, enrollments, profile
    - Can create an enrollment
    - Can edit draft enrollments
    - Can view submitted enrollments
    
2. __Service admin__
    
    This user type can edit and view enrollments just as a service agent
    can, but it can also edit provider types and the screening schedule.
    This user type is most likely appropriate for someone working for a
    state and overseeing enrollment and service agents.
    
    - Can view: provider dashboard and enrollments
    
    - Functions:
        - View and edit provider types
        - Edit screening schedule
        - Add and edit help topics
        - Add and edit agreements/addendums
        - View, create, edit, and delete other service agents

3. __System admin__
    
    This user type is purely for managing users, which none of the other
    user types can do.
    
    - Can only view "user account" screen
    - Functions
        - Create, edit, and delete users
        - Edit the abilities of user roles, but doesn't seem to be able
          to create new roles

4. __Providers__
    
    The user type with the lowest level of permissions, a provider
    should only be able to create, view, and edit their own enrollments.

    - View own enrollments
    - Create and edit enrollments


 ## TBD: Screening vs. Management

_Note: the following is one possible way for the PSM to handle screening
and management.  It is included here as a start for discussion, not as a
conclusive decision._

The PSM is a screening module, meaning that it focuses on determining
whether providers are eligible to participate in Medicaid.  However, the
information that providers enter into the PSM is subsequently used by
the state to manage those providers, and by the providers to manage
their own enrollment in Medicaid and other state programs.  For this
reason, screening and management modules can be difficult to
disentangle.  A provider should have one front page to use to both apply
for enrollment (be screened) and manage their enrollment.

One approach is to present these two tasks through the same portal for
the provider, but to separate them from a technical perspective.  To do
this, the screening application would essentially just be a form that
takes information from a provider, runs automated checks on it, allows
an administrator to review the information, and returns a status of
either "enrolled" or "not enrolled."  The screening module would send
the bundle of entered data to the management module, which would use the
same SSO solution, so that from the provider's perspective the two
modules feel like part of the same application.

The homepage for providers could look something like this:

```
------------------------------------------------------
|                                         | Logout | |
|                                                    |
| +-----------------+    +------------------------+  |
| |  Click here to  |    |     Click here to      |  |
| | apply to enroll |    | manage your enrollment |  |
| +-----------------+    +------------------------+  |
|                                                    |
|                                                    |
|                                                    |
|                                                    |
------------------------------------------------------
```

"Apply to enroll" would be the screening module, and "manage your
enrollment" would be the management module.  The latter would include
"update your information," "renew your enrollment," and "terminate your
enrollment."  In a fully-fledged management module, providers would also
be able to see and track the status of their claims in that area.  It
might be worth adding another button to the homepage for a separate
billing module.

```
------------------------------------------------------
|                                         | Logout | |
|                                                    |
| +-----------------+    +------------------------+  |
| |  Click here to  |    |     Click here to      |  |
| | apply to enroll |    | manage your enrollment |  |
| +-----------------+    +------------------------+  |
|                                                    |
| +-------------------+                              |
| | Track your claims |                              |
| +-------------------+                              |
------------------------------------------------------
```

For state reviewers/administrators, there'd be two kinds of action:
reviewing the information provided for screening purposes and
reviewing/paying claims.  Their portal would reflect these two kinds of
task.  When a provider updates information or renews or terminates their
enrollment, that new set of information would go into the "screening"
queue for state reviewers.  The management module would need to have
some way of bundling that information up and sending it back to the
screening module, perhaps with some metadata about what changed,
e.g. "the only piece of information that changed is the address."

