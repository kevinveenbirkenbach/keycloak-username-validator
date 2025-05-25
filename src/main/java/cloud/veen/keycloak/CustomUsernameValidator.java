package cloud.veen.keycloak;

import org.keycloak.provider.ConfiguredProvider;
import org.keycloak.provider.ProviderConfigProperty;
import org.keycloak.validate.AbstractStringValidator;
import org.keycloak.validate.ValidationContext;
import org.keycloak.validate.ValidationError;
import org.keycloak.validate.ValidatorConfig;

import java.util.Collections;
import java.util.List;

public class CustomUsernameValidator extends AbstractStringValidator implements ConfiguredProvider {

    public static final String ID = "custom-username-validator";

    @Override
    public String getId() {
        return ID;
    }

    @Override
    public String getHelpText() {
        return "Only lowercase letters and numbers are allowed.";
    }

    @Override
    public List<ProviderConfigProperty> getConfigProperties() {
        return Collections.emptyList();
    }

    @Override
    protected void doValidate(String value, String inputHint, ValidationContext context, ValidatorConfig config) {
        if (value == null || !value.matches("^[a-z0-9]+$")) {
            context.addError(new ValidationError(ID, inputHint, "Only lowercase letters and numbers are allowed."));
        }
    }
}
