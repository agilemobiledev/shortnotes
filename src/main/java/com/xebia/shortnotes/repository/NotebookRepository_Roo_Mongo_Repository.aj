// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.xebia.shortnotes.repository;

import com.xebia.shortnotes.domain.Notebook;
import com.xebia.shortnotes.repository.NotebookRepository;
import java.math.BigInteger;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

privileged aspect NotebookRepository_Roo_Mongo_Repository {
    
    declare parents: NotebookRepository extends PagingAndSortingRepository<Notebook, BigInteger>;
    
    declare @type: NotebookRepository: @Repository;
    
}
