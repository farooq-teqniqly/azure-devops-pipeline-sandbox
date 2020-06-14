import setuptools
import os

from contoso import version

def main():
    cwd = os.getcwd()
    abspath = os.path.abspath(__file__)
    dir_name = os.path.dirname(abspath)
    os.chdir(dir_name)

    print("DIR NAME: {}".format(dir_name))

    with open(os.path.join(dir_name, "README.md"), "r") as f:
        long_description = f.read()

    setuptools.setup(
        name="teqniqly-azure-devops-pipeline-example",
        version=version,
        author="Teqniqly",
        author_email="farooq@teqniqly.com",
        description="An Azure DevOps pipeline example.",
        license="MIT",
        long_description=long_description,
        long_description_content_type="text/markdown",
        packages=["contoso"],
        include_package_data=True,
        keywords=[],
        install_requires=[],
        test_suite="tests",
        platforms="Platform Independent",
        package_data={"teqniqly-azure-devops-pipeline-example": ["LICENSE", "README.md"]},
        classifiers=[
            "Development Status :: 4 - Beta",
            "Intended Audience :: Developers",
            "Programming Language :: Python :: 3.5",
            "Programming Language :: Python :: 3.6",
            "Programming Language :: Python :: 3.7",
            "Programming Language :: Python :: 3.8",
            "License :: OSI Approved :: MIT License",
            "Operating System :: OS Independent",
        ],
        python_requires=">=3.5",
    )

    # Pop back to the original directory.
    os.chdir(cwd)


if __name__ == "__main__":
    main()
