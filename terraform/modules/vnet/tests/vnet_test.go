Go
package test

import (
	"testing"

	"[github.com/gruntwork-io/terratest/modules/azure](https://www.google.com/search?q=https://github.com/gruntwork-io/terratest/modules/azure)"
	"[github.com/gruntwork-io/terratest/modules/random](https://www.google.com/search?q=https://github.com/gruntwork-io/terratest/modules/random)"
	"[github.com/gruntwork-io/terratest/modules/terraform](https://www.google.com/search?q=https://github.com/gruntwork-io/terratest/modules/terraform)"
	"[github.com/stretchr/testify/assert](https://www.google.com/search?q=https://github.com/stretchr/testify/assert)"
)

func TestAzureBasicVNetExample(t *testing.T) {
	t.Parallel()

	// Configuración única para esta prueba (evita colisiones si se ejecutan en paralelo)
	uniquePostfix := random.UniqueId()
	vnetName := "vnet-test-" + uniquePostfix
	rgName := "rg-test-" + uniquePostfix
	location := "westeurope" // O obtener de una variable de entorno

	// Configurar opciones de Terraform
	terraformOptions := &terraform.Options{
		// Ruta al módulo o ejemplo que quieres probar
		TerraformDir: "../examples/sample_vnet",

		// Variables a pasar al módulo
		Vars: map[string]interface{}{
			"resource_group_name": rgName,
			"location":            location,
			"vnet_name":           vnetName,
			"vnet_address_space":  []string{"10.0.0.0/16"},
			"subnets": map[string]interface{}{
				"testsubnet": map[string]interface{}{
					"name":             "snet-test-" + uniquePostfix,
					"address_prefixes": []string{"10.0.1.0/24"},
				},
			},
		},
	}


	// Ejecutar 'terraform init' y 'terraform apply' y asegurarse de que 'terraform destroy' se ejecute al final
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// --- Verificaciones ---

	// Verificar que la VNet existe y tiene las propiedades correctas
	vnet := azure.GetVirtualNetwork(t, vnetName, rgName, "")
	assert.Equal(t, vnetName, *vnet.Name)
	assert.Equal(t, location, *vnet.Location)
	assert.Contains(t, *vnet.AddressSpace.AddressPrefixes, "10.0.0.0/16")

	// Verificar que la subred existe y tiene las propiedades correctas
	subnetName := "snet-test-" + uniquePostfix
	subnet := azure.GetSubnet(t, subnetName, vnetName, rgName, "")
	assert.Equal(t, subnetName, *subnet.Name)
	assert.Contains(t, *subnet.AddressPrefix, "10.0.1.0/24")

}
