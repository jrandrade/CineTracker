//
//  MovieCollectionViewModelTests.swift
//  CineTrackerTests
//
//  Created by Jorge Andrade on 24/08/2023.
//

import XCTest
@testable import CineTracker

class MovieCollectionViewModelTests: XCTestCase {

    var mockGetPaginatedMovieList: MockGetPaginatedMovieList!
    var sut: MovieCollectionViewModel!

    override func setUp() {
        super.setUp()
        mockGetPaginatedMovieList = .init()
        sut = .init(title: "", getPaginatedMovieList: mockGetPaginatedMovieList)
    }

    // MARK: - ViewDidLoad -
    
    func test_GetPaginatedMovieListIsInvoked_When_CallingViewDidLoad() {
        // Arrange
        mockGetPaginatedMovieList.stubbedExecuteResult = .stub()

        let expectation = expectation(description: "ViewDidLoad")

        let cancellable = sut.$state
            .dropFirst(2)
            .first()
            .sink {
                _ in
                expectation.fulfill()
            }

        // Act
        sut.viewDidLoad()
        wait(for: [expectation], timeout: 0.5)

        // Assert
        XCTAssert(mockGetPaginatedMovieList.invokedExecute)
        XCTAssertEqual(mockGetPaginatedMovieList.invokedExecuteParameters?.page, 1)
    }

    func test_CellViewModelsAreCorrect_When_CallingViewDidLoad() {
        // Arrange
        mockGetPaginatedMovieList.stubbedExecuteResult = .stub(
            movies: [
                .stub(title: "some title 1"),
                .stub(title: "some title 2")
            ]
        )

        let expectation = expectation(description: "ViewDidLoad")

        let cancellable = sut.$state
            .removeDuplicates()
            .dropFirst()
            .first()
            .sink {
                _ in
                expectation.fulfill()
            }

        // Act
        sut.viewDidLoad()
        wait(for: [expectation], timeout: 0.5)

        // Assert
        XCTAssertEqual(sut.cellViewModels.count, 2)
        XCTAssertEqual(sut.cellViewModels[0].title, "some title 1")
        XCTAssertEqual(sut.cellViewModels[1].title, "some title 2")
    }

    func test_EmitsStateSuccess_When_CallingViewDidLoad() {
        // Arrange
        mockGetPaginatedMovieList.stubbedExecuteResult = .stub()
        var emmitedState: MovieCollectionViewModel.State?

        let expectation = expectation(description: "ViewDidLoad")

        let cancellable = sut.$state
            .removeDuplicates()
            .dropFirst()
            .first()
            .sink {
                state in
                emmitedState = state
                expectation.fulfill()
            }

        // Act
        sut.viewDidLoad()
        wait(for: [expectation], timeout: 0.5)

        // Assert
        XCTAssertEqual(emmitedState, .success)
    }

    func test_EmitsStateError_When_CallingViewDidLoad_Whislt_GetPaginatedMovieListThrowsError() {
        // Arrange
        mockGetPaginatedMovieList.stubbedExecuteError = NSError.stub()
        var emmitedState: MovieCollectionViewModel.State?

        let expectation = expectation(description: "ViewDidLoad")

        let cancellable = sut.$state
            .removeDuplicates()
            .dropFirst()
            .first()
            .sink {
                state in
                emmitedState = state
                expectation.fulfill()
            }

        // Act
        sut.viewDidLoad()
        wait(for: [expectation], timeout: 0.5)

        // Assert
        XCTAssertEqual(emmitedState, .error)
    }

    // MARK: - ShouldLoadMore -

    func test_ReturnsFalse_When_CallingShouldLoadMore_Whilst_IndexIsLessThenMinimum() {
        // Arrange
        mockGetPaginatedMovieList.stubbedExecuteResult = .stub(
            movies: [
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub()
            ]
        )

        let expectation = expectation(description: "ViewDidLoad")

        let cancellable = sut.$state
            .removeDuplicates()
            .dropFirst()
            .first()
            .sink {
                _ in
                expectation.fulfill()
            }

        sut.viewDidLoad()
        wait(for: [expectation], timeout: 0.5)

        // Act
        let result = sut.shouldLoadMore(at: 1)

        // Assert
        XCTAssertFalse(result)
    }

    func test_ReturnsTrue_When_CallingShouldLoadMore_Whilst_IndexIsGreaterThenMinimum() {
        // Arrange
        mockGetPaginatedMovieList.stubbedExecuteResult = .stub(
            movies: [
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub(),
                .stub()
            ]
        )

        let expectation = expectation(description: "ViewDidLoad")

        let cancellable = sut.$state
            .removeDuplicates()
            .dropFirst()
            .first()
            .sink {
                _ in
                expectation.fulfill()
            }

        sut.viewDidLoad()
        wait(for: [expectation], timeout: 0.5)

        // Act
        let result = sut.shouldLoadMore(at: 10)

        // Assert
        XCTAssert(result)
    }

    // MARK: - LoadMoreIfNeeded -

    func test_CellViewModelsAreCorrect_When_CallingLoadMoreIfNeeded() {
        // Arrange
        mockGetPaginatedMovieList.stubbedExecuteResult = .stub(
            movies: [
                .stub(title: "some title 1"),
                .stub(title: "some title 2")
            ],
            totalPages: 3
        )

        let viewDidLoadExpectation = expectation(description: "ViewDidLoad")

        let cancellable = sut.$state
            .removeDuplicates()
            .dropFirst()
            .first()
            .sink {
                _ in
                viewDidLoadExpectation.fulfill()
            }

        sut.viewDidLoad()
        wait(for: [viewDidLoadExpectation], timeout: 0.5)

        let loadMoreIfNeededExpectation = expectation(description: "LoadMoreIfNeeded")

        let loadMoreIfNeededCancellable = sut.$state
            .removeDuplicates()
            .dropFirst(2)
            .first()
            .sink {
                _ in
                loadMoreIfNeededExpectation.fulfill()
            }

        mockGetPaginatedMovieList.stubbedExecuteResult = .stub(
            movies: [
                .stub(title: "some title 3"),
                .stub(title: "some title 4")
            ]
        )

        // Act
        sut.loadMoreIfNeeded()
        wait(for: [loadMoreIfNeededExpectation], timeout: 0.5)

        // Assert
        XCTAssertEqual(sut.cellViewModels.count, 4)
        XCTAssertEqual(sut.cellViewModels[0].title, "some title 1")
        XCTAssertEqual(sut.cellViewModels[1].title, "some title 2")
        XCTAssertEqual(sut.cellViewModels[2].title, "some title 3")
        XCTAssertEqual(sut.cellViewModels[3].title, "some title 4")
    }

    func test_EmitsStateSuccess_When_CallingLoadMoreIfNeeded() {
        // Arrange
        mockGetPaginatedMovieList.stubbedExecuteResult = .stub(totalPages: 2)

        let viewDidLoadExpectation = expectation(description: "ViewDidLoad")

        let cancellable = sut.$state
            .removeDuplicates()
            .dropFirst()
            .first()
            .sink {
                _ in
                viewDidLoadExpectation.fulfill()
            }

        sut.viewDidLoad()
        wait(for: [viewDidLoadExpectation], timeout: 0.5)

        let loadMoreIfNeededExpectation = expectation(description: "LoadMoreIfNeeded")
        var emmitedState: MovieCollectionViewModel.State?

        let loadMoreIfNeededCancellable = sut.$state
            .removeDuplicates()
            .dropFirst(2)
            .first()
            .sink {
                state in
                emmitedState = state
                loadMoreIfNeededExpectation.fulfill()
            }

        mockGetPaginatedMovieList.stubbedExecuteResult = .stub()

        // Act
        sut.loadMoreIfNeeded()
        wait(for: [loadMoreIfNeededExpectation], timeout: 0.5)

        // Assert
        XCTAssertEqual(emmitedState, .success)
    }

    func test_EmitsStateError_When_CallingLoadMoreIfNeeded_Whislt_GetPaginatedMovieListThrowsError() {
        // Arrange
        mockGetPaginatedMovieList.stubbedExecuteResult = .stub(totalPages: 2)

        let viewDidLoadExpectation = expectation(description: "ViewDidLoad")

        let cancellable = sut.$state
            .removeDuplicates()
            .dropFirst()
            .first()
            .sink {
                _ in
                viewDidLoadExpectation.fulfill()
            }

        sut.viewDidLoad()
        wait(for: [viewDidLoadExpectation], timeout: 0.5)

        let loadMoreIfNeededExpectation = expectation(description: "LoadMoreIfNeeded")
        var emmitedState: MovieCollectionViewModel.State?

        let loadMoreIfNeededCancellable = sut.$state
            .removeDuplicates()
            .dropFirst(2)
            .first()
            .sink {
                state in
                emmitedState = state
                loadMoreIfNeededExpectation.fulfill()
            }

        mockGetPaginatedMovieList.stubbedExecuteError = NSError.stub()

        // Act
        sut.loadMoreIfNeeded()
        wait(for: [loadMoreIfNeededExpectation], timeout: 0.5)

        // Assert
        XCTAssertEqual(emmitedState, .loadingMoreError)
    }

    // MARK: DidSelectItem

    func test_ReturnsMovieDetailsNavigator_When_CallingDidSelectItem_Whilst_MovieExists() {
        // Arrange
        mockGetPaginatedMovieList.stubbedExecuteResult = .stub(movies: [.stub()], totalPages: 2)

        let viewDidLoadExpectation = expectation(description: "ViewDidLoad")

        let cancellable = sut.$state
            .removeDuplicates()
            .dropFirst()
            .first()
            .sink {
                _ in
                viewDidLoadExpectation.fulfill()
            }

        sut.viewDidLoad()
        wait(for: [viewDidLoadExpectation], timeout: 0.5)

        // Act
        let result = sut.didSelectItem(at: 0)

        // Assert
        XCTAssert(result is MovieDetailsNavigator)
    }

    func test_ReturnsNil_When_CallingDidSelectItem_Whilst_MovieDoNotExist() {
        // Arrange
        mockGetPaginatedMovieList.stubbedExecuteResult = .stub(movies: [.stub()], totalPages: 2)

        let viewDidLoadExpectation = expectation(description: "ViewDidLoad")

        let cancellable = sut.$state
            .removeDuplicates()
            .dropFirst()
            .first()
            .sink {
                _ in
                viewDidLoadExpectation.fulfill()
            }

        sut.viewDidLoad()
        wait(for: [viewDidLoadExpectation], timeout: 0.5)

        // Act
        let result = sut.didSelectItem(at: 2)

        // Assert
        XCTAssertNil(result)
    }
}
