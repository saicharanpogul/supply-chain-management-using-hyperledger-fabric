package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"

	"github.com/fatih/color"
	"github.com/jung-kurt/gofpdf"
)

// Test Org1 API
func org1Test() {
	url := "http://20.193.158.41/indonesianfarmorg1"
	method := "GET"

	payload := strings.NewReader("")

	client := &http.Client{}
	req, err := http.NewRequest(method, url, payload)

	if err != nil {
		fmt.Println(err)
	}
	res, err := client.Do(req)
	if err != nil {
		color.Red("Request Failed")
		return
	}
	defer res.Body.Close()
	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		color.Red("Request Failed")
		return
	}
	if string(body) == `{"response":"Test Pass!..."}` {
		color.Green(string(body))
	} else {
		color.Red(string(body))
	}
}

// Test Org3 API
func org3Test() {
	url := "http://20.193.158.41/rubbershipperorg3"
	method := "GET"

	payload := strings.NewReader("")

	client := &http.Client{}
	req, err := http.NewRequest(method, url, payload)

	if err != nil {
		fmt.Println(err)
	}
	res, err := client.Do(req)
	if err != nil {
		color.Red("Request Failed")
		return
	}
	defer res.Body.Close()
	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		color.Red("Request Failed")
		return
	}
	if string(body) == `{"response":"Test Pass!..."}` {
		color.Green(string(body))
	} else {
		color.Red(string(body))
	}
}

// Test Org4 API
func org4Test() {
	url := "http://20.193.158.41/goodscustomorg4"
	method := "GET"

	payload := strings.NewReader("")

	client := &http.Client{}
	req, err := http.NewRequest(method, url, payload)

	if err != nil {
		fmt.Println(err)
	}
	res, err := client.Do(req)
	if err != nil {
		color.Red("Request Failed")
		return
	}
	defer res.Body.Close()
	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		color.Red("Request Failed")
		return
	}
	if string(body) == `{"response":"Test Pass!..."}` {
		color.Green(string(body))
	} else {
		color.Red(string(body))
	}
}

// Test Org2 API
func org2Test() {
	url := "http://20.193.158.41/usclientorg2"
	method := "GET"

	payload := strings.NewReader("")

	client := &http.Client{}
	req, err := http.NewRequest(method, url, payload)

	if err != nil {
		fmt.Println(err)
	}
	res, err := client.Do(req)
	if err != nil {
		color.Red("Request Failed")
		return
	}
	defer res.Body.Close()
	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		color.Red("Request Failed")
		return
	}
	if string(body) == `{"response":"Test Pass!..."}` {
		color.Green(string(body))
	} else {
		color.Red(string(body))
	}
}

// Org1 Register and Enroll User
func registerEnrollUser(username string) {
	url := "http://20.193.158.41/registerenrolluserorg1/"
	method := "POST"

	payload := strings.NewReader("{\n    \"username\" : \"" + username + "\"\n}")

	client := &http.Client{}
	req, err := http.NewRequest(method, url, payload)
	req.Header.Set("Content-Type", "application/json")

	if err != nil {
		fmt.Println(err)
	}
	res, err := client.Do(req)
	if err != nil {
		color.Red("Request Failed")
		return
	}
	defer res.Body.Close()
	body, err := ioutil.ReadAll(res.Body)

	if string(body)[:15] != `{"status":"pass` {
		color.Green(string(body))
	} else {
		color.Red(string(body))
	}
}

// Org1 Generate Rubber Certificate
func generateRubberCert(username string, rubberBatchNumber string, rubberType string, hardness string, tensileStrength string, weight string, date string) {
	url := "http://20.193.158.41/generaterubbercert/"
	method := "POST"

	payload := strings.NewReader("{\n    \"username\": \"" + username + "\",\n    \"rubberBatchNumber\": \"" + rubberBatchNumber + "\",\n    \"rubberType\": \"" + rubberType + "\",\n    \"hardness\": \"" + hardness + "\",\n    \"rubberCertHolder\": \"indonesian farm\",\n    \"tensileStrength\": \"" + tensileStrength + "\",\n    \"weight\": \"" + weight + "\",\n    \"buyer\": \"us client\",\n    \"date\": \"" + date + "\"\n}")

	client := &http.Client{}
	req, err := http.NewRequest(method, url, payload)
	req.Header.Set("Content-Type", "application/json")
	if err != nil {
		fmt.Println(err)
	}
	res, err := client.Do(req)
	if err != nil {
		color.Red("Request Failed")
		return
	}
	defer res.Body.Close()
	body, err := ioutil.ReadAll(res.Body)

	if string(body)[:14] != `{"result":null` {
		color.Green(string(body))
	} else {
		color.Red(string(body))
	}

}

// Org1 Query Generated Rubber Certificate
func queryGeneratedRubberCert(username string, rubberBatchNumber string) {
	url := "http://20.193.158.41/querygeneratedrubbercert"
	method := "GET"

	payload := strings.NewReader("{\n\"username\":\"" + username + "\",\n\"rubberBatchNumber\":\"" + rubberBatchNumber + "\"\n}")

	client := &http.Client{}
	req, err := http.NewRequest(method, url, payload)
	req.Header.Set("Content-Type", "application/json")
	if err != nil {
		fmt.Println(err)
	}
	res, err := client.Do(req)
	if err != nil {
		color.Red("Request Failed")
		return
	}
	defer res.Body.Close()
	body, err := ioutil.ReadAll(res.Body)
	if string(body)[:14] != `{"result":null` {
		color.Green(string(body))
	} else {
		color.Red(string(body))
	}
}

// Org1 Transfer Rubber Certificate to Org3 (Rubber Shipper)
func transferRubberCert(username string, rubberBatchNumber string) {
	url := "http://20.193.158.41/transferrubbercert/"
	method := "PUT"

	payload := strings.NewReader("{\n    \"username\": \"" + username + "\",\n    \"rubberBatchNumber\": \"" + rubberBatchNumber + "\",\n    \"newRubberCertHolder\": \"rubber shipper\"\n}")

	client := &http.Client{}
	req, err := http.NewRequest(method, url, payload)
	req.Header.Set("Content-Type", "application/json")
	if err != nil {
		fmt.Println(err)
	}
	res, err := client.Do(req)
	if err != nil {
		color.Red("Request Failed")
		return
	}
	defer res.Body.Close()
	body, err := ioutil.ReadAll(res.Body)

	if string(body)[:14] != `{"result":null` {
		color.Green(string(body))
	} else {
		color.Red(string(body))
	}
}

// Capture the Stdout to get the out put of queryGeneratedRubberCert()
func capture(username string, rubberBatchNumber string) string {
	url := "http://20.193.158.41/querygeneratedrubbercert"
	method := "GET"

	payload := strings.NewReader("{\n\"username\":\"" + username + "\",\n\"rubberBatchNumber\":\"" + rubberBatchNumber + "\"\n}")

	client := &http.Client{}
	req, err := http.NewRequest(method, url, payload)
	req.Header.Set("Content-Type", "application/json")
	if err != nil {
		fmt.Println(err)
	}
	res, err := client.Do(req)
	if err != nil {
		color.Red("Request Failed")
		return ""
	}
	defer res.Body.Close()
	body, err := ioutil.ReadAll(res.Body)
	if string(body)[:14] == `{"result":null` {
		color.Red(string(body))
	}

	return string(body)
}

func generatePDF(data string) {
	pdf := gofpdf.New("P", "mm", "A4", "")
	pdf.AddPage()
	pdf.SetFont("Times", "", 12)

	pdf.MultiCell(0, 5, string(data), "", "", false)
	err := pdf.OutputFileAndClose("rubberCert.pdf")
	if err == nil {
		color.Green("PDF is Generated")
	} else {
		color.Red("Failed to generate PDF.")
	}
}

func main() {

	// Test API Service
	// org1Test()
	// org3Test()
	// org4Test()
	// org2Test()

	// Org1 APIs
	// Register and Enroll User for Org1
	var username0 string
	color.Cyan("REGISTER AND ENROLL USER IN ORG1")
	color.Yellow("Only First Name")
	color.Blue("Enter Username:")
	fmt.Scanln(&username0)
	registerEnrollUser(username0)

	// Generate Rubber Certificate
	var username1 string
	var rubberBatchNumber1 string
	var rubberType string
	var hardness string
	var tensileStrength string
	var weight string
	var date string
	color.Cyan("GENERATE RUBBER CERTIFICATE")
	color.Yellow("rubberCertHolder: 'indonesian farm' & buyer: 'us client' are set to default")
	color.Blue("Enter Username:")
	fmt.Scanln(&username1)
	color.Blue("Enter Rubber Batch Number (eg - rubber1, rubber1):")
	fmt.Scanln(&rubberBatchNumber1)
	color.Blue("Enter Rubber Type (eg- Natural_Rubber, Neoprene_Rubber, Silicone_Rubber, Nitrile_Rubber):")
	fmt.Scanln(&rubberType)
	color.Blue("Enter Hardness (eg - Shore_00, Shore_A, Shore_D):")
	fmt.Scanln(&hardness)
	color.Blue("Enter Tensile Strength (eg - 10-25 MPa):")
	fmt.Scanln(&tensileStrength)
	color.Blue("Enter Weight (in 1000 Kgs):")
	fmt.Scanln(&weight)
	color.Blue("Enter Date (DD-MM-YYYY):")
	fmt.Scanln(&date)
	generateRubberCert(username1, rubberBatchNumber1, rubberType, hardness, tensileStrength, weight, date)

	// Query Generated Rubber Certificate
	var username2 string
	var rubberBatchNumber2 string
	color.Cyan("QUERY GENERATED RUBBER CERTIFICATE")
	fmt.Println("Enter Username:")
	fmt.Scanln(&username2)
	fmt.Println("Enter Rubber Batch Number (eg - rubber1, rubber2):")
	fmt.Scanln(&rubberBatchNumber2)
	queryGeneratedRubberCert(username2, rubberBatchNumber2)

	// Transfer Rubber Certificate
	var username3 string
	var rubberBatchNumber3 string
	color.Cyan("QUERY GENERATED RUBBER CERTIFICATE")
	color.Yellow("newRubberCertHolder is set to default - Rubber Shipper")
	fmt.Println("Enter Username:")
	fmt.Scanln(&username3)
	fmt.Println("Enter Rubber Batch Number (eg - rubber1, rubber2):")
	fmt.Scanln(&rubberBatchNumber3)
	transferRubberCert(username3, rubberBatchNumber3)

	// Query Generated Rubber Certificate - Recheck
	var username4 string
	var rubberBatchNumber4 string
	color.Cyan("QUERY GENERATED RUBBER CERTIFICATE - RECHECK")
	fmt.Println("Enter Username:")
	fmt.Scanln(&username4)
	fmt.Println("Enter Rubber Batch Number (eg - rubber1, rubber2):")
	fmt.Scanln(&rubberBatchNumber4)
	queriedData := capture(username4, rubberBatchNumber4)

	generatePDF(queriedData)
	// Org3 APIs
	// Register and Enroll User for Org3
	// Generate Shipping Bill
	// Query Generated Shipping Bill
	// Transfer Shipping Bill

	// Org4 APIs
	// Register and Enroll User for Org4
	// Generate Approval Certificate
	// Query Generated Approval Certificate
	// Transfer Approval Certificate

	// Org2 APIs
	// Register and Enroll User for Org2
	// Get All Three Documents

}