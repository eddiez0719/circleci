FROM python:3.8-alpine

ARG version=v0.44.3
RUN pip install cfn-lint==$version
RUN pip install pydot

ENTRYPOINT ["cfn-lint"]
#ENTRYPOINT ["echo","Hello"]
#CMD ["--help"]
CMD ["Eddie"]
