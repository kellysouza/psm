package gov.medicaid.features;

import cucumber.api.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;


/**
 * Integration test glue for serenity
 * This test runs all of the features.
 */

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(features = "src/test/resources/features")
public class IntegrationTests {

}
