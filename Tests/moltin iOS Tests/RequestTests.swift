// Generated using Sourcery 0.10.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest

@testable
import moltin

class Author: Codable, Equatable {
    let name: String
    init(withName name: String) {
        self.name = name
    }
    static func ==(lhs: Author, rhs: Author) -> Bool {
        return lhs.name == rhs.name
    }
}

class MyCustomBrand: moltin.Brand {
    let author: Author
    enum BrandCodingKeys: String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BrandCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}

class MyCustomCategory: moltin.Category {
    let author: Author
    enum CategoryCodingKeys: String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}

class MyCustomCollection: moltin.Collection {
    let author: Author
    enum CollectionCodingKeys: String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CollectionCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}

class MyCustomCurrency: moltin.Currency {
    let author: Author
    enum CurrencyCodingKeys: String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurrencyCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}

class MyCustomFile: moltin.File {
    let author: Author
    enum FileCodingKeys: String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FileCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}

class MyCustomField: moltin.Field {
    let author: Author
    enum FieldCodingKeys: String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FieldCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}

class MyCustomProduct: moltin.Product {
    let author: Author
    enum ProductCodingKeys: String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}

// MARK: BrandRequestTest - AutoMoltinRequest

class BrandRequestTests: XCTestCase {

    let treeJson = """
        {
          "id": "51b56d92-ab99-4802-a2c1-be150848c629",
          "author": {
            "name": "Craig"
          }
        }
    """

    func testBrandRequestReturnsBrands() {
        let (_, brandRequest) = MockFactory.mockedBrandRequest(withJSON: MockBrandsDataFactory.multiBrandsData)
        let expectationToFulfill = expectation(description: "BrandRequest calls the method and runs the callback closure")
        _ = brandRequest.all { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == Optional<[moltin.Brand]>.self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testBrandRequestReturnSingleBrand() {
        let (_, brandRequest) = MockFactory.mockedBrandRequest(withJSON: MockBrandsDataFactory.brandData)
        let expectationToFulfill = expectation(description: "BrandRequest calls the method and runs the callback closure")
        _ = brandRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response) == moltin.Brand.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testBrandRequestReturnsCustomBrands() {
        let (_, brandRequest) = MockFactory.mockedBrandRequest(withJSON: MockBrandsDataFactory.customMultiBrandsData)
        let expectationToFulfill = expectation(description: "BrandRequest calls the method and runs the callback closure")
        _ = brandRequest.all { (result: Result<PaginatedResponse<[MyCustomBrand]>>) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == Optional<[MyCustomBrand]>.self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testBrandRequestReturnCustomSingleBrand() {
        let (_, brandRequest) = MockFactory.mockedBrandRequest(withJSON: MockBrandsDataFactory.customBrandData)
        let expectationToFulfill = expectation(description: "BrandRequest calls the method and runs the callback closure")

        _ = brandRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result: Result<MyCustomBrand>) in
            switch result {
            case .success(let response):
                let author = Author(withName: "Craig")
                XCTAssert(type(of: response) == MyCustomBrand.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                XCTAssert(response.author == author)
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
// MARK: CategoryRequestTest - AutoMoltinRequest

class CategoryRequestTests: XCTestCase {
    let productJson = """
                {
                  "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                  "author": {
                    "name": "Craig"
                  }
                }
                """
    let multiProductJson = """
                {
                  "data":
                    [{
                      "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                      "author": {
                        "name": "Craig"
                      }
                    }],
                    "meta": {
                    }
                }
                """

    let treeJson = """
        {
          "id": "51b56d92-ab99-4802-a2c1-be150848c629",
          "author": {
            "name": "Craig"
          }
        }
    """

    func testCategoryRequestReturnsCategorys() {
        let (_, categoryRequest) = MockFactory.mockedCategoryRequest(withJSON: MockCategoryDataFactory.multiCategoryData)
        let expectationToFulfill = expectation(description: "CategoryRequest calls the method and runs the callback closure")
        _ = categoryRequest.all { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == Optional<[moltin.Category]>.self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testCategoryRequestReturnSingleCategory() {
        let (_, categoryRequest) = MockFactory.mockedCategoryRequest(withJSON: MockCategoryDataFactory.categoryData)
        let expectationToFulfill = expectation(description: "CategoryRequest calls the method and runs the callback closure")
        _ = categoryRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response) == moltin.Category.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testCategoryRequestReturnsCustomCategorys() {
        let (_, categoryRequest) = MockFactory.mockedCategoryRequest(withJSON: MockCategoryDataFactory.customMultiCategoryData)
        let expectationToFulfill = expectation(description: "CategoryRequest calls the method and runs the callback closure")
        _ = categoryRequest.all { (result: Result<PaginatedResponse<[MyCustomCategory]>>) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == Optional<[MyCustomCategory]>.self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testCategoryRequestReturnCustomSingleCategory() {
        let (_, categoryRequest) = MockFactory.mockedCategoryRequest(withJSON: MockCategoryDataFactory.customCategoryData)
        let expectationToFulfill = expectation(description: "CategoryRequest calls the method and runs the callback closure")

        _ = categoryRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result: Result<MyCustomCategory>) in
            switch result {
            case .success(let response):
                let author = Author(withName: "Craig")
                XCTAssert(type(of: response) == MyCustomCategory.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                XCTAssert(response.author == author)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
// MARK: CollectionRequestTest - AutoMoltinRequest

class CollectionRequestTests: XCTestCase {

    func testCollectionRequestReturnCollections() {
    let (_, collectionRequest) = MockFactory.mockedCollectionRequest(withJSON: MockCollectionDataFactory.multiCollectionData)
        let expectationToFulfill = expectation(description: "CollectionRequest calls the method and runs the callback closure")
        _ = collectionRequest.all { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == Optional<[moltin.Collection]>.self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testCollectionRequestReturnSingleCollection() {
        let (_, collectionRequest) = MockFactory.mockedCollectionRequest(withJSON: MockCollectionDataFactory.collectionData)
        let expectationToFulfill = expectation(description: "CollectionRequest calls the method and runs the callback closure")
        _ = collectionRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response) == moltin.Collection.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testCollectionRequestReturnsCustomCollections() {
        let (_, collectionRequest) = MockFactory.mockedCollectionRequest(withJSON: MockCollectionDataFactory.customMultiCollectionData)
        let expectationToFulfill = expectation(description: "CollectionRequest calls the method and runs the callback closure")
        _ = collectionRequest.all { (result: Result<PaginatedResponse<[MyCustomCollection]>>) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == Optional<[MyCustomCollection]>.self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testCollectionRequestReturnCustomSingleCollection() {
        let (_, collectionRequest) = MockFactory.mockedCollectionRequest(withJSON: MockCollectionDataFactory.customCollectionData)
        let expectationToFulfill = expectation(description: "CollectionRequest calls the method and runs the callback closure")

        _ = collectionRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result: Result<MyCustomCollection>) in
            switch result {
            case .success(let response):
                let author = Author(withName: "Craig")
                XCTAssert(type(of: response) == MyCustomCollection.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                XCTAssert(response.author == author)
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
// MARK: CurrencyRequestTest - AutoMoltinRequest

class CurrencyRequestTests: XCTestCase {

    func testCurrencyRequestReturnsCurrencys() {
        let (_, currencyRequest) = MockFactory.mockedCurrencyRequest(withJSON: MockCurrencyDataFactory.multiCurrencyData)
        let expectationToFulfill = expectation(description: "CurrencyRequest calls the method and runs the callback closure")
        _ = currencyRequest.all { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == Optional<[moltin.Currency]>.self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testCurrencyRequestReturnSingleCurrency() {
        let (_, currencyRequest) = MockFactory.mockedCurrencyRequest(withJSON: MockCurrencyDataFactory.currencyData)
        let expectationToFulfill = expectation(description: "CurrencyRequest calls the method and runs the callback closure")
        _ = currencyRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response) == moltin.Currency.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

}
// MARK: FileRequestTest - AutoMoltinRequest

class FileRequestTests: XCTestCase {

    func testFileRequestReturnsFiles() {
        let (_, fileRequest) = MockFactory.mockedFileRequest(withJSON: MockFileDataFactory.multiFileData)
        let expectationToFulfill = expectation(description: "FileRequest calls the method and runs the callback closure")
        _ = fileRequest.all { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == Optional<[moltin.File]>.self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testFileRequestReturnSingleFile() {
        let (_, fileRequest) = MockFactory.mockedFileRequest(withJSON: MockFileDataFactory.fileData)
        let expectationToFulfill = expectation(description: "FileRequest calls the method and runs the callback closure")
        _ = fileRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response) == moltin.File.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

}
// MARK: FieldRequestTest - AutoMoltinRequest

class FieldRequestTests: XCTestCase {

    func testFieldRequestReturnsFields() {
        let (_, fieldRequest) = MockFactory.mockedFieldRequest(withJSON: MockFieldDataFactory.multiFieldData)
        let expectationToFulfill = expectation(description: "FieldRequest calls the method and runs the callback closure")
        _ = fieldRequest.all { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == Optional<[moltin.Field]>.self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testFieldRequestReturnSingleField() {
        let (_, fieldRequest) = MockFactory.mockedFieldRequest(withJSON: MockFieldDataFactory.fieldData)
        let expectationToFulfill = expectation(description: "FieldRequest calls the method and runs the callback closure")
        _ = fieldRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response) == moltin.Field.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

}
// MARK: ProductRequestTest - AutoMoltinRequest

class ProductRequestTests: XCTestCase {
    let productJson = """
                {
                  "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                  "author": {
                    "name": "Craig"
                  }
                }
                """
    let multiProductJson = """
                {
                  "data":
                    [{
                      "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                      "author": {
                        "name": "Craig"
                      }
                    }],
                    "meta": {
                    }
                }
                """

    let treeJson = """
        {
          "id": "51b56d92-ab99-4802-a2c1-be150848c629",
          "author": {
            "name": "Craig"
          }
        }
    """

    func testProductRequestReturnsProducts() {
        let (_, productRequest) = MockFactory.mockedProductRequest(withJSON: MockProductDataFactory.multiProductData)
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        _ = productRequest.all { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == Optional<[moltin.Product]>.self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testProductRequestReturnSingleProduct() {
        let (_, productRequest) = MockFactory.mockedProductRequest(withJSON: MockProductDataFactory.productData)
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        _ = productRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response) == moltin.Product.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testProductRequestReturnsCustomProducts() {
        let (_, productRequest) = MockFactory.mockedProductRequest(withJSON: MockProductDataFactory.customMultiProductData)
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        _ = productRequest.all { (result: Result<PaginatedResponse<[MyCustomProduct]>>) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == Optional<[MyCustomProduct]>.self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testProductRequestReturnCustomSingleProduct() {
        let (_, productRequest) = MockFactory.mockedProductRequest(withJSON: MockProductDataFactory.customProductData)
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")

        _ = productRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result: Result<MyCustomProduct>) in
            switch result {
            case .success(let response):
                let author = Author(withName: "Craig")
                XCTAssert(type(of: response) == MyCustomProduct.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                XCTAssert(response.author == author)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

}